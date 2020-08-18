import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_init/pin_code_init_events.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_init/pin_code_init_states.dart';
import 'package:zimsmobileapp/presentation/screens/pin_code/pin_code_enter.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/main.dart';

class PinCodeInitScreen extends StatefulWidget {
  @override
  _PinCodeInitScreenState createState() => _PinCodeInitScreenState();
}

class _PinCodeInitScreenState extends State<PinCodeInitScreen>
    with ThemeProviderMixin {
  Color _grayBackground;
  Color _darkGray;
  Color _lightGray;

  refresh() {
    setState(() {});
    if (dotNum == 4) {
      if (!pinFlag) {
      BlocProvider.of<PinCodeInitBloc>(context).add(EnteredFirstTimeEvent(pinEnter: pinEnter));
      pinFlag = true;
      } else {
        BlocProvider.of<PinCodeInitBloc>(context).add(EnteredSecondTimeEvent(pinEnter: pinEnter));
      }
    }
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
                title: Text(allTranslations.text("pin_init.title"),
                    style: TextStyle(color: Colors.black, fontSize: 17)),
                backgroundColor: _grayBackground,
                iconTheme: IconThemeData(color: _darkGray),
                leading: IconButton(
                  icon: Icon(Icons.help_outline,
                      color: getAppThemeData(context).primaryColor),
                  onPressed: () => _onHelpPressed(),
                  tooltip: allTranslations.text("pin_help.title"),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear,
                        color: getAppThemeData(context).primaryColor),
                    onPressed: _onSkipPressed,
                    tooltip: allTranslations.text("pin_skip.title"),
                  ),
                ],
              ),
              body: BlocListener<PinCodeInitBloc, PinCodeInitState>(
                listener: (context, state) {
                  setState(() {});
                  if (state is PinCodeInitErrorState) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 1250),
                        content: Text(allTranslations.text("pin_init.no_match")),
                      ),
                    );
                  }
                },
                child: BlocBuilder<PinCodeInitBloc, PinCodeInitState>(
                  builder: (context, state){
                    if (state is InitialPinCodeInitState) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              allTranslations.text("pin_init.enter_first"),
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
                      );
                    }
                    if (state is EnterPinSecondTimeState) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              allTranslations.text("pin_init.enter_second"),
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
                      );
                    }
                    if (state is PinCodeInitErrorState) {
                      BlocProvider.of<PinCodeInitBloc>(context).add(EnteredWrongPinEvent());
                    }
                    return Center();
                  },
                )
              ),
            ),
    );
  }

  _onHelpPressed() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
         return Platform.isAndroid
              ? _createAndroidHelpMessage(context)
              : _createIosHelpMessage(context);
        });
  }

  AlertDialog _createAndroidHelpMessage(BuildContext context) {
    return AlertDialog(
      title: Text(allTranslations.text("pin_help.title")),
      content: Container(
        width: double.maxFinite,
        child: ListView(
          children: <Widget>[
            Text(allTranslations.text("pin_help.msg"),
            style: TextStyle(fontSize: 20))
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {Navigator.pop(context);},
        ),
      ],
    );
  }

  CupertinoAlertDialog _createIosHelpMessage(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(allTranslations.text("pin_help.title")),
      content: ListView(
        children: <Widget>[
          Text(allTranslations.text("pin_help.msg"))
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("OK"),
          isDefaultAction: true,
          isDestructiveAction: false,
          onPressed: () {Navigator.pop(context);},
        ),
      ],
    );
  }

  _onSkipPressed() async {
    bool isSkipped = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isAndroid
              ? _createAndroidSkipDialog(context)
              : _createIosSkipDialog(context);
        });
    BlocProvider.of<PinCodeInitBloc>(context).add(SkippedPinInitializationEvent(isSkipped: isSkipped));
  }

  AlertDialog _createAndroidSkipDialog(BuildContext context) {
    return AlertDialog(
      title: Text(allTranslations.text("pin_skip.title")),
      content: Text(allTranslations.text("pin_skip.are_you_sure")),
      actions: <Widget>[
        FlatButton(
          child: Text(allTranslations.text("pin_skip.no")),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text(allTranslations.text("pin_skip.yes")),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  CupertinoAlertDialog _createIosSkipDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(allTranslations.text("pin_skip.title")),
      content: Text(allTranslations.text("pin_skip.are_you_sure")),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(allTranslations.text("pin_skip.no")),
          isDefaultAction: true,
          isDestructiveAction: false,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        CupertinoDialogAction(
          child: Text(allTranslations.text("pin_skip.yes")),
          isDefaultAction: false,
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}