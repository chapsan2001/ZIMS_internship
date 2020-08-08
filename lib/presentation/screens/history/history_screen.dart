import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/history/history_events.dart';
import 'package:zimsmobileapp/domain/blocs/history/history_states.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';
import 'package:intl/intl.dart';

import '../document_type_name_mixin.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with ThemeProviderMixin, DocumentTypeNameMixin {
  Color _grayBackground;
  Color _darkGray;
  Color _lightGray;

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

  DocumentType parseDocumentType(String name) {
    if (name.contains("VISA")) {
      return DocumentType.VISA;
    } else if (name.contains("PERMIT")) {
      return DocumentType.PERMIT;
    } else if (name.contains("PASSPORT")) {
      return DocumentType.PASSPORT;
    } else if (name.contains("RECEIPT")) {
      return DocumentType.RECEIPT;
    } else {
      throw UnimplementedError("Provide existing document type!"+name);
    }
  }

  _onListTileTapped(int index) {
    final _pd = Hive.box('history').getAt(index) as PermitData;
    BlocProvider.of<HistoryBloc>(context).add(TapOnDocEvent(
        documentInfo: DocumentInfo(
            documentType: parseDocumentType(_pd.permitType.toUpperCase()),
            documentNumber: _pd.permitNumber)));
  }

  Widget historyCardTemplate(int i){
    int index = Hive.box('history').length-1-i;
    final _pd = Hive.box('history').getAt(index) as PermitData;
    return GestureDetector(
      onTap: () => _onListTileTapped(index),
      child: Card(
          elevation: 1,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                radius: 27,
                backgroundColor: getAppThemeData(context).primaryColor,
                child: CircleAvatar(
                  radius: 24.5,
                  backgroundColor: Colors.white,
                  child: Text((i+1).toString(),
                      style: TextStyle(color: Colors.black, fontSize: 19)
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 3),
                    Text(allTranslations.text("history.document_type")+_pd.documentType, style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    Text(allTranslations.text("history.document_number")+_pd.documentNumber, style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    Text(allTranslations.text("history.permit_type")+_pd.permitType, style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    Text(allTranslations.text("history.permit_number")+_pd.permitNumber, style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    Text(allTranslations.text("history.date_time_scanned")+DateFormat.yMEd().add_jms().format(_pd.timeScanned), style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    SizedBox(height: 3),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {},
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          int listTilesCount;
          bool histFlag;
          if (Hive.box('history').length == 0) {
            listTilesCount = 1;
            histFlag = false;
          } else {
            listTilesCount = Hive.box('history').length;
            histFlag = true;
          }
          return Scaffold(
            backgroundColor: _grayBackground,
            appBar: AppBar(
              elevation: 1,
              title: Text(
                  allTranslations.text("history.title"),
                style: TextStyle(color: Colors.black, fontSize: 17)
              ),
              backgroundColor: _grayBackground,
              iconTheme: IconThemeData(color: _darkGray),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  color: getAppThemeData(context).primaryColor,
                  onPressed: _onAskClearHistory,
                  tooltip: allTranslations.text("clear_history.title"),
                )
              ],
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: listTilesCount,
                itemBuilder: (BuildContext context, int index) {
                  if (histFlag) {
                    return historyCardTemplate(index);
                  } else {
                    return ListTile(
                      title: Text(allTranslations.text("history.no_docs"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
                      ),
                    );
                  }
                },
              ),
            )
          );
        },
      ),
    );
  }

  _onAskClearHistory() async {
    final isCleared = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isAndroid
              ? _createAndroidAlertDialog(context)
              : _createIosAlertDialog(context);
        }) ??
        false;

      BlocProvider.of<HistoryBloc>(context)
          .add(ConfirmHistoryClearEvent(isCleared: isCleared));
  }

  AlertDialog _createAndroidAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(allTranslations.text("clear_history.title")),
      content: Text(allTranslations.text("clear_history.are_you_sure")),
      actions: <Widget>[
        FlatButton(
          child: Text(allTranslations.text("clear_history.back")),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text(allTranslations.text("clear_history.clear")),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  CupertinoAlertDialog _createIosAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(allTranslations.text("clear_history.title")),
      content: Text(allTranslations.text("clear_history.are_you_sure")),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(allTranslations.text("clear_history.back")),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, false);
          },
          textStyle: TextStyle(color: Colors.grey),
        ),
        CupertinoDialogAction(
          child: Text(allTranslations.text("clear_history.clear")),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}