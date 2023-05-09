import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nyt/core/Network/network_info.dart';

import '../../features/mocks.mocks.dart';

void main() {
  late MockConnectionChecker mockNetworkInfo;
  setUp(() {
    mockNetworkInfo = MockConnectionChecker();
  });
  group('Network Info Test', () {
    test('return NetworkStatus.Offline when calling isConnected', () async {
      when(mockNetworkInfo.isConnected()).thenAnswer((realInvocation) => Future.value(NetworkStatus.Offline));

      var isConnected = await mockNetworkInfo.isConnected();
      expect(isConnected, NetworkStatus.Offline);
    });

    test('return NetworkStatus.Online when calling isConnected', () async {
      when(mockNetworkInfo.isConnected()).thenAnswer((realInvocation) => Future.value(NetworkStatus.Online));

      var isConnected = await mockNetworkInfo.isConnected();
      expect(isConnected, NetworkStatus.Online);
    });
  });
}
