import 'package:shared_preferences/shared_preferences.dart';
import 'package:zimsmobileapp/domain/utils/app_preferences.dart';

class AppPreferencesProvider implements AppPreferences {
  static const LANGUAGE_KEY = "language";

  static const TOKEN_KEY = "token";

  static const USER_NAME_KEY = "userName";

  static const LAST_RESUME_TIMESTAMP_KEY = "resumeTimestamp";

  @override
  Future<String> getLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(LANGUAGE_KEY) ?? '';
  }

  @override
  Future<bool> putLanguage(String language) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(LANGUAGE_KEY, language);
  }

  @override
  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(TOKEN_KEY) ?? '';
  }

  @override
  Future<bool> putToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(TOKEN_KEY, token);
  }

  @override
  Future<String> getUserName() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(USER_NAME_KEY) ?? '';
  }

  @override
  Future<bool> putUserName(String userName) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(USER_NAME_KEY, userName);
  }

  @override
  Future<int> getLastResumeTimestamp() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(LAST_RESUME_TIMESTAMP_KEY) ?? -1;
  }

  @override
  Future<bool> putLastResumeTimestamp(int timestamp) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setInt(LAST_RESUME_TIMESTAMP_KEY, timestamp);
  }
}
