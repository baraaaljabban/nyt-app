class ServerException implements Exception {
  var message;
  ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

class UnExpectedServerResponseException implements Exception {
  final message;
  UnExpectedServerResponseException(this.message);
}

class UnExpectedSocketException implements Exception {
  final message;
  UnExpectedSocketException(this.message);
}

class JSONException implements Exception {
  final message;
  JSONException({this.message});
}
