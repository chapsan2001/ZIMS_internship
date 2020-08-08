import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/blocs/login/login_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/login/login_events.dart';
import 'package:zimsmobileapp/domain/blocs/login/login_states.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with ThemeProviderMixin {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _areFieldsEmpty = true;

  Color _darkGreyColor;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(LoginLoadPreviousUserName());

    _userNameController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);

    _darkGreyColor = getColor(context, CustomColors.DARK_GRAY_COLOR);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginInitial) {
          if (state.userName.isNotEmpty) {
            _userNameController.text = state.userName;
          }
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Stack(
                children: <Widget>[
                  Form(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                        ),
                        Container(
                          width: 80,
                          height: 72,
                          child: Image.asset('assets/images/login_logo.png'),
                        ),
                        Container(
                          height: 16,
                        ),
                        Text(
                          allTranslations.text('login.department'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _darkGreyColor),
                        ),
                        Container(
                          height: 38,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: _buildInputDecoration(
                              allTranslations.text('login.username')),
                          controller: _userNameController,
                          enabled: state is! LoginLoading ? true : false,
                        ),
                        Container(
                          height: 8,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: _buildInputDecoration(
                              allTranslations.text('login.password')),
                          controller: _passwordController,
                          obscureText: true,
                          enabled: state is! LoginLoading ? true : false,
                        ),
                        Container(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            onPressed:
                                state is! LoginLoading && !_areFieldsEmpty
                                    ? _onLoginButtonPressed
                                    : null,
                            child: Text(
                              allTranslations.text('login.title'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            color: getAppThemeData(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        Visibility(
                          child: Text(
                            state is LoginFailure ? _getErrorText(state) : "",
                            style: TextStyle(
                                color: getAppThemeData(context).errorColor),
                          ),
                          visible: state is LoginFailure ? true : false,
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        visible: state is LoginFailure ? true : false,
                        child: Text(
                          allTranslations.text('login.forgot_password'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: _darkGreyColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  String _getErrorText(LoginFailure state) {
    if (state.exception is BadRequestException) {
      return allTranslations.text('login.invalid_login_or_password');
    } else if (state.exception is AppException) {
      return (state.exception as AppException).getPrefix();
    } else {
      return state.exception.toString() ?? "";
    }
  }

  InputDecoration _buildInputDecoration(String hint) {
    final fillColor = getColor(context, CustomColors.FILL_COLOR);
    final hintColor = getColor(context, CustomColors.HINT_COLOR);

    return InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8),
          ),
          borderSide: BorderSide(color: fillColor, width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8),
          ),
          borderSide: BorderSide(color: fillColor, width: 0.0),
        ),
        filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.all(4),
        hintStyle: TextStyle(color: hintColor, fontSize: 17),
        hintText: hint);
  }

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        userName: _userNameController.text,
        password: _passwordController.text,
      ),
    );
  }

  _onTextChanged() {
    final newValue =
        _userNameController.text.isEmpty || _passwordController.text.isEmpty;

    if (newValue != _areFieldsEmpty) {
      setState(() {
        _areFieldsEmpty = newValue;
      });
    }
  }
}
