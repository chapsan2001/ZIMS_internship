class LoginRequest {
  final String userName;
  final String password;

  LoginRequest({this.userName, this.password});

  Map toJson() => {
        'userName': userName,
        'password': password,
      };
}
