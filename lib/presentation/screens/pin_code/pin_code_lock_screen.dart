import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_lock/pin_code_lock_events.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_lock/pin_code_lock_states.dart';
import 'package:zimsmobileapp/presentation/screens/pin_code/pin_code_enter.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/main.dart';

class PinCodeLockScreen extends StatefulWidget {
  @override
  _PinCodeLockScreenState createState() => _PinCodeLockScreenState();
}

class _PinCodeLockScreenState extends State<PinCodeLockScreen> with ThemeProviderMixin {
  Color _grayBackground;
  Color _darkGray;
  Color _lightGray;

  refresh() {
    setState(() {
      if (dotNum == 4) {
        if (pinEnter[0] == pin[0] && pinEnter[1] == pin[1] && pinEnter[2] == pin[2] && pinEnter[3] == pin[3]) {
          BlocProvider.of<PinCodeLockBloc>(context).add(UnlockedEvent());
        } else {
          BlocProvider.of<PinCodeLockBloc>(context).add(EnteredWrongPinEvent(attempts: attempts));
        }
        pinEnter = [null, null, null, null];
        dots = [false, false, false, false];
        dotNum = 0;
      }
    });
  }

  void initState() {
    super.initState();
    _grayBackground = getColor(context, CustomColors.GRAY_BACKGROUND_COLOR);
    _darkGray = getColor(context, CustomColors.DARK_GRAY_COLOR);
    _lightGray = getColor(context, CustomColors.GRAY_LIGHT_COLOR);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: _grayBackground,
        appBar: AppBar(
          elevation: 1,
          title: Text(allTranslations.text("pin_lock.title"),
              style: TextStyle(color: Colors.black, fontSize: 17)),
          backgroundColor: _grayBackground,
          iconTheme: IconThemeData(color: _darkGray),
          actions: <Widget>[
            IconButton(
              icon: ImageIcon(
                AssetImage(
                  "assets/images/ic_logout.png",
                ),
                color: getAppThemeData(context).primaryColor,
              ),
              onPressed: _onAskLogout,
              tooltip: allTranslations.text("logout.title"),
            )
          ],
        ),
        body: BlocListener<PinCodeLockBloc, PinCodeLockState>(
          listener: (context, state) {
            setState(() {});
            if (state is PinCodeLockErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1250),
                  content: (attempts != 1)
                      ? Text(allTranslations.text("pin_lock.wrong_pin")+attempts.toString()+allTranslations.text("pin_lock.attempts_left"))
                      : Text(allTranslations.text("pin_lock.wrong_pin")+attempts.toString()+allTranslations.text("pin_lock.attempt_left")),
                  action: SnackBarAction(
                    label: allTranslations.text("logout.title"),
                    onPressed: _onAskLogout,
                  ),
                ),
              );
            }
          },
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(allTranslations.text("pin_lock.enter"),
                  style: TextStyle(fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CircleAvatar(
                          radius: 12.5,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: dots[0] ? Colors.black : Colors.white,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CircleAvatar(
                          radius: 12.5,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: dots[1] ? Colors.black : Colors.white,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CircleAvatar(
                          radius: 12.5,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: dots[2] ? Colors.black : Colors.white,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CircleAvatar(
                          radius: 12.5,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: dots[3] ? Colors.black : Colors.white,
                          )
                      ),
                    )
                  ],
                ),
                PinCodeEnter(notifyParent: refresh),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAskLogout() async {
    final isLogout = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isAndroid
              ? _createAndroidLogOutDialog(context)
              : _createIosLogOutDialog(context);
        });
    BlocProvider.of<PinCodeLockBloc>(context)
        .add(LoggedOutEvent(isLogout: isLogout));
  }

  AlertDialog _createAndroidLogOutDialog(BuildContext context) {
    return AlertDialog(
      title: Text(allTranslations.text('logout.title')),
      content: Text(allTranslations.text('logout.are_you_sure')),
      actions: <Widget>[
        FlatButton(
          child: Text(allTranslations.text('logout.back')),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text(allTranslations.text('logout.title')),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  CupertinoAlertDialog _createIosLogOutDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(allTranslations.text('logout.title')),
      content: Text(allTranslations.text('logout.are_you_sure')),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(allTranslations.text('logout.back')),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, false);
          },
          textStyle: TextStyle(color: Colors.grey),
        ),
        CupertinoDialogAction(
          child: Text(allTranslations.text('logout.title')),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}