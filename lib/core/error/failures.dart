abstract class Failure {
  final String message;
  Failure(this.message);
}

class InternetConnectionFailure extends Failure {
  InternetConnectionFailure(String message) : super(message);
}
class InternetConnectionFailures extends Failure {
  InternetConnectionFailures() : super("");
}

class UnExpectedServerResponseFailure extends Failure {
  UnExpectedServerResponseFailure(String message) : super(message);
}

class UnknownFailuer extends Failure {
  UnknownFailuer({required String message}) : super(message);
}

