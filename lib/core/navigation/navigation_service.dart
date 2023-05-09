import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop({dynamic result}) {
    return _navigationKey.currentState?.pop(result);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndPushTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  /// if removeUntilNamed is null,
  /// remove all screen and make [pushNamed] screen become root
  Future<dynamic> pushAndRemoveUntil(String pushNamed,
      {String? removeUntilNamed,
      Object? arguments,
      bool checkSameRoute = false}) async {
    if (checkSameRoute) {
      if (!isCurrent(pushNamed)) {
        _navigate(pushNamed,
            arguments: arguments, removeUntilNamed: removeUntilNamed);
      }
    } else {
      _navigate(pushNamed,
          arguments: arguments, removeUntilNamed: removeUntilNamed);
    }
  }

  Future<dynamic> _navigate(
    String pushNamed, {
    String? removeUntilNamed,
    Object? arguments,
  }) {
    if (removeUntilNamed != null) {
      return _navigationKey.currentState!.pushNamedAndRemoveUntil(
        pushNamed,
        ModalRoute.withName(removeUntilNamed),
        arguments: arguments,
      );
    } else {
      return _navigationKey.currentState!.pushNamedAndRemoveUntil(
        pushNamed,
        (route) => false,
        arguments: arguments,
      );
    }
  }

  void popUntil({String? popUntilNamed}) {
    if (popUntilNamed != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _navigationKey.currentState!
            .popUntil(ModalRoute.withName(popUntilNamed));
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _navigationKey.currentState!.popUntil((route) => route.isFirst);
      });
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    _navigationKey.currentState?.popUntil((route) {
      if (route.settings.name == routeName || route.settings.name == null) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}

final NavigationService navigationService = NavigationService();
