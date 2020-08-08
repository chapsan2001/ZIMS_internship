import 'package:flutter/material.dart';
import 'package:zimsmobileapp/domain/utils/app_pause_manager.dart';

class AppStateObserver extends StatefulWidget {
  final MaterialApp app;
  final AppPauseManager appPauseManager;

  AppStateObserver({@required this.app, @required this.appPauseManager});

  @override
  State createState() => _AppStateObserverState();
}

class _AppStateObserverState extends State<AppStateObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.appPauseManager.onCreate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);

    switch (state) {
      case AppLifecycleState.paused:
        widget.appPauseManager.onPause();
        break;
      case AppLifecycleState.resumed:
        widget.appPauseManager.onResume();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.app;
  }
}
