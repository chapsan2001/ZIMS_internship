import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/blocs/enter_id/enter_id_events.dart';
import 'package:zimsmobileapp/domain/blocs/enter_id/enter_id_states.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/main.dart';
import 'package:zimsmobileapp/presentation/screens/document_type_name_mixin.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';

class EnterIdScreen extends StatefulWidget {
  @override
  State createState() => _EnterIdScreenState();
}

class _EnterIdScreenState extends State<EnterIdScreen>
    with ThemeProviderMixin, DocumentTypeNameMixin {
  Color _grayBackground;
  Color _darkGray;
  Color _lightGray;

  bool _isIdEmpty = true;
  DocumentType _documentType = DocumentType.PERMIT;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _documentIdController = TextEditingController();
  final _documentIdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _grayBackground = getColor(context, CustomColors.GRAY_BACKGROUND_COLOR);
    _darkGray = getColor(context, CustomColors.DARK_GRAY_COLOR);
    _lightGray = getColor(context, CustomColors.GRAY_LIGHT_COLOR);

    _documentIdController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _documentIdController.dispose();
    _documentIdFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<EnterIdBloc, EnterIdState>(
        listener: (context, state) {
          if (state is QrScanErrorState) {
            _showQrErrorSnackBar(context);
          } else if (state is ReceivedDocumentTypeState) {
            setState(() {
              _documentType = state.documentType;
            });
            _documentIdFocusNode.requestFocus();
          }
        },
        child: BlocBuilder<EnterIdBloc, EnterIdState>(
          builder: (context, state) {
            return GestureDetector(
              child: Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: false,
                backgroundColor: _grayBackground,
                appBar: AppBar(
                  elevation: 1,
                  title: Text(
                    allTranslations.text("enter_id.title"),
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  backgroundColor: _grayBackground,
                  iconTheme: IconThemeData(color: _darkGray),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.history),
                      color: getAppThemeData(context).primaryColor,
                      onPressed: _onHistoryOpen,
                      tooltip: allTranslations.text("history.title"),
                    ),
                    Visibility(
                      visible: pinFlag,
                      child: IconButton(
                        icon: Icon(
                          Icons.lock_outline,
                          color: getAppThemeData(context).primaryColor,
                        ),
                        onPressed: _onAskLock,
                        tooltip: allTranslations.text("lock_the_app.title"),
                      ),
                    ),
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
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 28,
                        ),
                        GestureDetector(
                          onTap: _onDocumentTypeChangePressed,
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 14, 0, 14),
                                  child: Text(
                                    allTranslations.text(
                                        "enter_id.document_type"),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16, 14, 16, 14),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          getDocumentTypeName(_documentType),
                                          style: TextStyle(
                                              color: _darkGray, fontSize: 15),
                                        ),
                                        Container(
                                          width: 12,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: _darkGray,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        Container(
                          color: Colors.white,
                          child: TextField(
                            onSubmitted: (String val) =>
                            !_isIdEmpty
                                ? _onFindDocumentPressed()
                                : null,
                            focusNode: _documentIdFocusNode,
                            controller: _documentIdController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                    borderRadius: BorderRadius.zero),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                    borderRadius: BorderRadius.zero),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.fromLTRB(
                                    16, 4, 16, 4),
                                hintStyle:
                                TextStyle(color: _lightGray, fontSize: 15),
                                hintText: allTranslations.text(
                                    "enter_id.title"),
                                suffixIcon: !_isIdEmpty
                                    ? GestureDetector(
                                  onTap: _onClearDocumentId,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    padding: EdgeInsets.all(14),
                                    child: RawMaterialButton(
                                      elevation: 0,
                                      onPressed: null,
                                      fillColor: _darkGray,
                                      child: Icon(
                                        Icons.close,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                )
                                    : null),
                          ),
                        )
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 34),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: RaisedButton(
                                    child: Text(
                                      allTranslations
                                          .text("enter_id.find_document"),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    onPressed:
                                    !_isIdEmpty ? _onFindDocumentPressed : null,
                                    color: getAppThemeData(context)
                                        .primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: OutlineButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        ImageIcon(
                                          AssetImage(
                                            "assets/images/ic_qr_scan.png",
                                          ),
                                          color:
                                          getAppThemeData(context).primaryColor,
                                        ),
                                        Container(
                                          width: 12,
                                        ),
                                        Text(
                                          allTranslations
                                              .text("enter_id.scan_qr_code"),
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: getAppThemeData(context)
                                                  .primaryColor),
                                        )
                                      ],
                                    ),
                                    onPressed: _onScanQrCodePressed,
                                    color: _grayBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(8),
                                      ),
                                    ),
                                    borderSide: BorderSide(
                                        color: _grayBackground),
                                    highlightedBorderColor: _grayBackground,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            );
          },
        ),
      ),
    );
  }

  // Utils
  _onTextChanged() {
    if (_documentIdController.text.isEmpty != _isIdEmpty) {
      setState(() {
        _isIdEmpty = _documentIdController.text.isEmpty;
      });
    }
  }

  _showQrErrorSnackBar(BuildContext context) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(allTranslations.text('enter_id.scan_qr_error')),
    ));
  }

  // Actions
  _onFindDocumentPressed() {
    BlocProvider.of<EnterIdBloc>(context).add(FindDocumentPressedEvent(
        documentInfo: DocumentInfo(
            documentType: _documentType,
            documentNumber: _documentIdController.text)));
  }

  _onScanQrCodePressed() {
    BlocProvider.of<EnterIdBloc>(context).add(ScanQrPressedEvent());
  }

  _onDocumentTypeChangePressed() {
    BlocProvider.of<EnterIdBloc>(context)
        .add(GetDocumentTypeEvent(currentDocumentType: _documentType));
  }

  _onClearDocumentId() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _documentIdController.clear());
  }

  // Log out
  _onAskLogout() async {
    final isLogout = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isAndroid
              ? _createAndroidLogOutDialog(context)
              : _createIosLogOutDialog(context);
        });

    BlocProvider.of<EnterIdBloc>(context)
        .add(ConfirmLogoutEvent(isLogout: isLogout));
  }

  // History open
  _onHistoryOpen() async {
    BlocProvider.of<EnterIdBloc>(context).
    add(HistoryOpenEvent());
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

  _onAskLock() async {
    final isLocked = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isAndroid
              ? _createAndroidLockDialog(context)
              : _createIosLockDialog(context);
        });
    BlocProvider.of<EnterIdBloc>(context)
        .add(ConfirmLockEvent(isLocked: isLocked));
  }

  AlertDialog _createAndroidLockDialog(BuildContext context) {
    return AlertDialog(
      title: Text(allTranslations.text("lock_the_app.title")),
      content: Text(allTranslations.text("lock_the_app.are_you_sure")),
      actions: <Widget>[
        FlatButton(
          child: Text(allTranslations.text("lock_the_app.back")),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text(allTranslations.text("lock_the_app.lock")),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  CupertinoAlertDialog _createIosLockDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(allTranslations.text("lock_the_app.title")),
      content: Text(allTranslations.text("lock_the_app.are_you_sure")),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(allTranslations.text("lock_the_app.back")),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, false);
          },
          textStyle: TextStyle(color: Colors.grey),
        ),
        CupertinoDialogAction(
          child: Text(allTranslations.text("lock_the_app.lock")),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
