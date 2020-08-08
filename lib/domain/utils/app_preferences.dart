abstract class AppPreferences {
  Future<String> getLanguage();

  Future<bool> putLanguage(String language);

  Future<String> getToken();

  Future<bool> putToken(String token);

  Future<String> getUserName();

  Future<bool> putUserName(String userName);

  Future<int> getLastResumeTimestamp();

  Future<bool> putLastResumeTimestamp(int timestamp);
}
