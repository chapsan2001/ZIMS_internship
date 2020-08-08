abstract class NavigationManager {
  Future<dynamic> pushRoute(String route, [dynamic arguments]);

  Future<dynamic> pushRouteWithReplacement(String route, [dynamic arguments]);

  void goBack([dynamic arguments]);
}
