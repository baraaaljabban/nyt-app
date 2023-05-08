import 'dart:convert';

import 'package:http/http.dart';

class FailedResponse {
  int status;
  String message;
  Map<String, dynamic> data;

  FailedResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'message': message});

    return result;
  }

  factory FailedResponse.fromMap(Map<String, dynamic> map,
      {Response? response}) {
    return FailedResponse(
      status:
          int.tryParse(map['status'].toString()) ?? response?.statusCode ?? 0,
      message: map.containsKey('message') ? map['message'].toString() : '',
      data: map.containsKey('data') ? map['data'] : {},
    );
  }

  String toJson() => json.encode(toMap());

  factory FailedResponse.fromJson(String source) =>
      FailedResponse.fromMap(json.decode(source));
}

class Data {
  int statusCode;
  String error;
  String message;
  // List<Detail> details;

  Data({
    required this.statusCode,
    required this.error,
    required this.message,
    // required this.details,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'statusCode': statusCode});
    result.addAll({'error': error});
    result.addAll({'message': message});
    // result.addAll({'details': details.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      statusCode: map['statusCode']?.toInt() ?? 0,
      error: map['error'] ?? '',
      message: map['message'] ?? '',
      // details: List<Detail>.from(map['details']?.map((x) => Detail.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
  factory Data.fromNull() => Data(error: "", message: "", statusCode: 0);
  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));
}

class Detail {
  String message;
  String path;
  String type;
  Context context;

  Detail({
    required this.message,
    required this.path,
    required this.type,
    required this.context,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'message': message});
    result.addAll({'path': path});
    result.addAll({'type': type});
    result.addAll({'context': context.toMap()});

    return result;
  }

  factory Detail.fromMap(Map<String, dynamic> map) {
    return Detail(
      message: map['message'] ?? '',
      path: map['path'] ?? '',
      type: map['type'] ?? '',
      context: Context.fromMap(map['context']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Detail.fromJson(String source) => Detail.fromMap(json.decode(source));
}

class Context {
  String value;
  List<String> invalids;
  String label;
  String key;

  Context({
    required this.value,
    required this.invalids,
    required this.label,
    required this.key,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'value': value});
    result.addAll({'invalids': invalids});
    result.addAll({'label': label});
    result.addAll({'key': key});

    return result;
  }

  factory Context.fromMap(Map<String, dynamic> map) {
    return Context(
      value: map['value'] ?? '',
      invalids: List<String>.from(map['invalids']),
      label: map['label'] ?? '',
      key: map['key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Context.fromJson(String source) =>
      Context.fromMap(json.decode(source));
}
