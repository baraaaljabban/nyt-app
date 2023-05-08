// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkStatus { Online, Offline }

abstract class ConnectionChecker {
  Future<NetworkStatus> isConnected();
}

class ConnectionCheckerImpl extends ConnectionChecker {
  @override
  Future<NetworkStatus> isConnected() async {
    return await InternetConnectionCheckerPlus().hasConnection ? NetworkStatus.Online : NetworkStatus.Offline;
  }
}
