import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/data/api/zims_api.dart';
import 'package:zimsmobileapp/data/server/requests/requests.dart';
import 'package:zimsmobileapp/domain/models/user.dart';
import 'package:zimsmobileapp/domain/repositories/auth_repository.dart';
import 'package:zimsmobileapp/domain/utils/app_preferences.dart';

class AuthService implements AuthRepository {
  final AppPreferences appPreferences;
  final ZimsApi api;

  AuthService({@required this.appPreferences, @required this.api});

  @override
  Future<User> login(String userName, String password) {
    final loginRequest = LoginRequest(userName: userName, password: password);

    return api.login(loginRequest).then((loginResponse) async {
      await appPreferences.putToken(loginResponse.token);
      await appPreferences.putUserName(userName);

      return User(
          firstName: loginResponse.firstName, lastName: loginResponse.lastName);
    });
  }

  @override
  Future<String> getLastUserName() {
    return appPreferences.getUserName();
  }
}
