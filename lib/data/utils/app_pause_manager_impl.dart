import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/domain/utils/app_pause_manager.dart';
import 'package:zimsmobileapp/domain/utils/app_preferences.dart';
import 'package:zimsmobileapp/main.dart';

class AppPauseManagerImpl implements AppPauseManager {
  // 3 minutes
  static const MAX_PAUSE_MILLIS = 3 * 60 * 1000;

  final AppPreferences appPreferences;
  final NavigationManager navigationManager;

  AppPauseManagerImpl(
      {@required this.appPreferences, @required this.navigationManager});

  @override
  Future<Null> onCreate() async =>
      appPreferences.putLastResumeTimestamp(-1).then((isSuccess) {
        return null;
      });

  @override
  Future<Null> onResume() async {
    final timestamp = _getCurrentTimestamp();

    appPreferences.getLastResumeTimestamp().then((lastTimestamp) {
      if (lastTimestamp > 0 && timestamp - lastTimestamp > MAX_PAUSE_MILLIS) {
        if (pinFlag) {
          navigationManager.pushRouteWithReplacement(Routes.PIN_CODE_LOCK);
        } else {
          navigationManager.pushRouteWithReplacement(Routes.LOGIN);
          attempts = 3;
          pinFlag = false;
          pin = [null, null, null, null];
          pinEnter = [null, null, null, null];
          dots = [false, false, false, false];
          dotNum = 0;
          userName = null;
        }
      }

      return null;
    });
  }

  @override
  Future<Null> onPause() async => appPreferences
      .putLastResumeTimestamp(_getCurrentTimestamp())
      .then((isSuccess) {
    return null;
  });

  int _getCurrentTimestamp() => DateTime.now().millisecondsSinceEpoch;
}
