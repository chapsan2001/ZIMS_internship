import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/presentation/screens/document_type_name_mixin.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';

class ChooseTypeScreen extends StatefulWidget {
  final DocumentType documentType;

  ChooseTypeScreen({@required this.documentType});

  @override
  State createState() => _ChooseTypeScreenState();
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen>
    with ThemeProviderMixin, DocumentTypeNameMixin {
  final _documentTypes = DocumentType.values;

  int _selectedIndex = 0;

  Color _grayBackground;
  Color _darkGray;
  Color _divider;

  @override
  void initState() {
    super.initState();

    _grayBackground = getColor(context, CustomColors.GRAY_BACKGROUND_COLOR);
    _darkGray = getColor(context, CustomColors.DARK_GRAY_COLOR);
    _divider = getColor(context, CustomColors.DIVIDER_COLOR);

    setState(() {
      _selectedIndex = _documentTypes.indexOf(widget.documentType);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: _onBackPressedEvent,
      child: Scaffold(
        backgroundColor: _grayBackground,
        appBar: AppBar(
            elevation: 1,
            title: Text(
              allTranslations.text("document_type.title"),
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            backgroundColor: _grayBackground,
            iconTheme: IconThemeData(color: _darkGray),
            leading: IconButton(
              icon: Platform.isAndroid
                  ? Icon(Icons.arrow_back)
                  : Icon(Icons.arrow_back_ios),
              onPressed: _onBackPressedEvent,
            )),
        body: Column(
          children: <Widget>[
            Container(
              height: 28,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return _buildDocumentTypeItem(index);
                },
                itemCount: _documentTypes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTypeItem(int index) {
    return GestureDetector(
      onTap: () => _onDocumentTypeSelected(index),
      child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 11, 16, 11),
                    child: Text(
                      getDocumentTypeName(_documentTypes[index]),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Visibility(
                      child: Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 24,
                      ),
                      visible: _selectedIndex == index,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Container(
                  height: 0.5,
                  color: _divider,
                ),
              ),
            ],
          )),
    );
  }

  _onDocumentTypeSelected(int index) {
    _selectedIndex = index;
    _onBackPressedEvent();
  }

  Future<bool> _onBackPressedEvent() async {
    Navigator.pop(context, _documentTypes[_selectedIndex]);
    return true;
  }
}
