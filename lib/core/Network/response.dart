

const int RESPONSE_SUCCESS = 200;
const String RESPONSE_ERROR = "ERROR";

class Response {
  final String responseCode, responseMessage;

  Response({required this.responseCode, required this.responseMessage});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
}
Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    responseCode: json['responseCode'] as String,
    responseMessage: json['responseMessage'] as String,
  );
}