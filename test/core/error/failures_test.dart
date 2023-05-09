import 'package:flutter_test/flutter_test.dart';
import 'package:nyt/core/error/failures.dart';

void main() {
  group('Failure Tests', () {
    test('JsonFormatFailure should have correct detailedMessage', () {
      final failure = JsonFormatFailure(message: 'Invalid JSON');
      expect(failure.detailedMessage, 'Invalid JSON [err: json_err]');
    });

    test('ConnectionUnavailableFailure should have correct detailedMessage', () {
      final failure = ConnectionUnavailableFailure();
      expect(failure.detailedMessage, 'No internet connection [err: conn_err]');
    });

    test('ServerFailure should have correct detailedMessage', () {
      final failure = ServerFailure(statusCode: 500, message: 'Internal Server Error');
      expect(failure.detailedMessage, 'Internal Server Error [err: server_err] [statusCode: null ?? 0]');
    });

    test('UnhandledServerFailure should have correct detailedMessage', () {
      final failure = UnhandledServerFailure(statusCode: 404, message: 'Not Found');
      expect(failure.detailedMessage, 'Not Found [err: unhandled_err] [statusCode: null]');
    });

    test('LogicFailure should have correct detailedMessage', () {
      final failure = LogicFailure(title: 'Logic Error', message: 'Invalid input');
      expect(failure.detailedMessage, 'Invalid input');
    });

    test('UnhandledFailure should have correct detailedMessage', () {
      final failure = UnhandledFailure(className: 'CustomClass', message: 'Unhandled exception');
      expect(failure.detailedMessage, 'Unhandled exception null [err: unhandled_failure] [className: CustomClass]');
    });

    test('ServerUnavailableFailure should have correct detailedMessage', () {
      final failure = ServerUnavailableFailure(statusCode: 503, message: 'Service Unavailable');
      expect(failure.detailedMessage, 'Service Unavailable [err: server_err] [statusCode: null ?? 0]');
    });

    test('ForbiddenFailure should have correct detailedMessage', () {
      final failure = ForbiddenFailure(statusCode: 403, message: 'Forbidden');
      expect(failure.detailedMessage, 'Forbidden [err: unauthorized_err] [statusCode: null ?? 0]');
    });

    test('MfaRequiredFailure should have correct detailedMessage', () {
      final failure = MfaRequiredFailure(title: 'MFA Required', message: 'Multi-factor authentication required');
      expect(failure.detailedMessage, 'Multi-factor authentication required');
    });

    test('InputFailure should have correct detailedMessage', () {
      final failure = InputFailure(message: 'Invalid input');
      expect(failure.detailedMessage, 'Invalid input');
    });
  });
}
