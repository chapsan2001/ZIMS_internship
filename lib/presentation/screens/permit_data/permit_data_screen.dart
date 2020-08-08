import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/blocs/permit_data/permit_data_events.dart';
import 'package:zimsmobileapp/domain/blocs/permit_data/permit_data_states.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';

class PermitDataScreen extends StatefulWidget {
  final DocumentInfo documentInfo;

  PermitDataScreen({@required this.documentInfo});

  @override
  State createState() => _PermitDataScreenState();
}

class _PermitDataScreenState extends State<PermitDataScreen>
    with ThemeProviderMixin {
  Color _grayBackground;
  Color _darkGray;
  Color _lightGray;
  Color _divider;

  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _grayBackground = getColor(context, CustomColors.GRAY_BACKGROUND_COLOR);
    _darkGray = getColor(context, CustomColors.DARK_GRAY_COLOR);
    _lightGray = getColor(context, CustomColors.GRAY_LIGHT_COLOR);
    _divider = getColor(context, CustomColors.DIVIDER_COLOR);

    BlocProvider.of<PermitDataBloc>(context)
        .add(FetchPermitDataEvent(documentInfo: widget.documentInfo));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: _grayBackground,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          allTranslations.text('permit_data.title'),
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: _grayBackground,
        iconTheme: IconThemeData(color: _darkGray),
        actions: <Widget>[
          Visibility(
            visible: widget.documentInfo.documentType == DocumentType.PERMIT,
            child: IconButton(
              icon: Container(
                  width: 24,
                  height: 20,
                  child: Image.asset('assets/images/ic_photo.png')),
              onPressed: _isLoaded ? _onPhotoPressed : null,
            ),
          )
        ],
      ),
      body: BlocListener<PermitDataBloc, PermitDataState>(
        listener: (context, state) {
          setState(() {
            _isLoaded = state is PermitDataLoaded;
          });
        },
        child: BlocBuilder<PermitDataBloc, PermitDataState>(
          builder: (context, state) {
            if (state is PermitDataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PermitDataError) {
              return Center(
                child: Text(_getTextError(state)),
              );
            }

            if (state is PermitDataNotFound) {
              return Center(
                child: Text(allTranslations.text('messages.not_found')),
              );
            }

            if (state is PermitDataLoaded) {
              return _buildMainView(state.permitData);
            }

            return Center();
          },
        ),
      ),
    );
  }

  String _getTextError(PermitDataError state) {
    if (state.exception is AppException) {
      return (state.exception as AppException).getPrefix();
    } else {
      return state.exception.toString() ?? "";
    }
  }

  Widget _buildMainView(PermitData data) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(data),

          // Document Section
          Container(
            height: 18,
          ),
          _buildItem(allTranslations.text('permit_data.valid_from'),
              _getDateValue(data.validFrom)),
          _buildItem(allTranslations.text('permit_data.valid_until'),
              _getDateValue(data.validUntil)),
          _buildItem(allTranslations.text('permit_data.issued_by'),
              _getStringValue(data.issuedBy)),

          // Passport section
          _buildSection(allTranslations.text('permit_data.passport')),
          _buildItem(allTranslations.text('permit_data.passport_number'),
              _getStringValue(data.passportNumber)),
          _buildItem(allTranslations.text('permit_data.country'),
              _getStringValue(data.country)),
          _buildItem(allTranslations.text('permit_data.issued_at'),
              _getStringValue(data.issuedAt)),
          _buildItem(allTranslations.text('permit_data.passport_issued_on'),
              _getDateValue(data.issuedOn)),
          _buildItem(allTranslations.text('permit_data.passport_expires_on'),
              _getDateValue(data.expiresOn)),

          // Person section
          _buildSection(allTranslations.text('permit_data.person')),
          _buildItem(allTranslations.text('permit_data.first_name'),
              _getStringValue(data.firstName)),
          _buildItem(allTranslations.text('permit_data.last_name'),
              _getStringValue(data.lastName)),
          _buildItem(allTranslations.text('permit_data.middle_name'),
              _getStringValue(data.middleName)),
          _buildItem(allTranslations.text('permit_data.file_number'),
              _getStringValue(data.fileNumber)),
          _buildItem(allTranslations.text('permit_data.gender'),
              _getStringValue(data.gender)),

          // Additional information
          _buildSection(
              allTranslations.text('permit_data.additional_information')),
          _buildItem(allTranslations.text('permit_data.comment'),
              _getStringValue(data.comment)),

          Container(
            height: 48,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(PermitData data) {
    final color = hexToColor(data.color);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: color,
                      child: SizedBox(
                        width: 12,
                        height: 12,
                      ),
                    ),
                  ),
                  Container(
                    width: 8,
                  ),
                  Container(
                    width: 210,
                    child: Text(
                      _getStringValue(data.permitType),
                      style: TextStyle(
                        fontSize: 15,
                        color: color,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Container(
                width: 8,
              ),
              Text(
                _getStringValue(data.documentStatus),
                style: TextStyle(
                    fontSize: 15, color: getAppThemeData(context).primaryColor),
              ),
            ],
          ),
          Container(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Text(_getStringValue(data.permitNumber),
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Container(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  data.fileNumber,
                  style: TextStyle(fontSize: 15, color: _darkGray),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 26, 16, 12),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 13, color: _lightGray),
          )
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 13, color: _lightGray),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 6, 16, 12),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: _divider,
          ),
        ],
      ),
    );
  }

  String _getStringValue(String value) =>
      value == null || value == "" ? "-" : value;

  String _getDateValue(DateTime value) =>
      value == null ? "-" : DateFormat("dd/MM/yyyy").format(value);

  _onPhotoPressed() {
    BlocProvider.of<PermitDataBloc>(context)
        .add(OpenPhotoEvent(documentInfo: widget.documentInfo));
  }
}
