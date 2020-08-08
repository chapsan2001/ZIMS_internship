import 'package:zimsmobileapp/domain/models/models.dart';

abstract class AuthRepository {
  Future<User> login(String userName, String password);

  Future<String> getLastUserName();
}
