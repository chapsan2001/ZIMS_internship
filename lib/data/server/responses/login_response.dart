class LoginResponse {
  final String token;
  final String firstName;
  final String lastName;

  LoginResponse({this.token, this.firstName, this.lastName});

  factory LoginResponse.fromJson(dynamic json) {
    return LoginResponse(
        token: json["token"],
        firstName: json["firstName"],
        lastName: json["lastName"]);
  }
}
