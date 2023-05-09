// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as http;

import '../AppStrings/server_strings.dart';
import '../error/error_handler.dart';
import '../error/exceptions.dart';
import 'network_info.dart';

abstract class HttpClient {
  /// hits a post request to [BASE_URL] + [url] with [body] as the as the body of the HTTP request
  ///

  ///hits a get request to [BASE_URL] + [url]
  Future<http.Response> getData({
    required String path,
    Map<String, String>? extraHeaders,
  });

  ///hits a get request to [BASE_URL] + [url]
}

class HttpClientImpl extends HttpClient with ErrorHandler {
  final ConnectionChecker connectionChecker;
  HttpClientImpl({
    required this.connectionChecker,
  });

  @override
  Future<http.Response> getData({required String path, Map<String, String>? extraHeaders}) async {
    await _throwExceptionIfNoConnection();

    var fullPath = "${getBaseURL()}${path}api-key=${getApiKey()}";
    developer.log('get Path: $fullPath');
    final response = await http.get(
      Uri.parse(fullPath),
      // headers: getHeaders(extraHeaders: extraHeders),
    );
    developer.log("get response : \n${utf8.decode(response.bodyBytes)}");
    return await _decodeResponseBodyOrThrowError(response);
  }

  Future<dynamic> _decodeResponseBodyOrThrowError(
    http.Response response,
  ) async {
    if ((response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) ||
        response.statusCode == HttpStatus.noContent) {
      return response;
    } else {
      throw await getNonSuccessHttpResponseException(response);
    }
  }

  String getBaseURL() {
    if (Foundation.kDebugMode) {
      return BaseURLSTAGING;
    } else {
      return BaseURL;
    }
  }

  String getApiKey() {
    if (Foundation.kDebugMode) {
      return ApiKeyStaging;
    } else {
      return ApiKey;
    }
  }

  Map<String, String> getHeaders({Map? extraHeaders}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'api-key': getApiKey(),
      // HttpHeaders.authorizationHeader: 'Bearer ' + getToken(),
    };
    if (extraHeaders == null || extraHeaders.isEmpty) {
      return headers;
    } else {
      headers.addAll(extraHeaders as Map<String, String>);
      return headers;
    }
  }

  /// helper function to check if mobile has connection
  Future<void> _throwExceptionIfNoConnection() async {
    if (await connectionChecker.isConnected() == NetworkStatus.Offline) {
      throw ConnectionUnavailableException();
    }
  }
}
