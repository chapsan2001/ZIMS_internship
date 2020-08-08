import 'package:flutter/material.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';

class NavigationManagerImpl implements NavigationManager {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationManagerImpl({@required this.navigatorKey});

  @override
  Future<dynamic> pushRoute(String route, [arguments]) async {
    return navigatorKey.currentState.pushNamed(route, arguments: arguments);
  }

  @override
  Future<dynamic> pushRouteWithReplacement(String route, [arguments]) async {
    return navigatorKey.currentState
        .pushReplacementNamed(route, arguments: arguments);
  }

  @override
  void goBack([arguments]) {
    navigatorKey.currentState.pop(arguments);
  }
}
