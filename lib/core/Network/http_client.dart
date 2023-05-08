import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as http;

import '../AppStrings/server_strings.dart';

class HttpHelper {
  HttpHelper();

  Future<http.Response> get({String path = "", Map<String, String>? extraHeders}) async {
    var fullPath = "${getBaseURL()}${path}api-key=${getApiKey()}";
    developer.log('get Path: $fullPath');
    final response = await http.get(
      Uri.parse(fullPath),
      // headers: getHeaders(extraHeaders: extraHeders),
    );
    developer.log("get response : \n${utf8.decode(response.bodyBytes)}");
    return response;
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
}
