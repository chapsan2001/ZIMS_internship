import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimsmobileapp/presentation/screens/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginForm(),
      ),
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }
}
