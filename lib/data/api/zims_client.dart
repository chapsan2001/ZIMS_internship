import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zimsmobileapp/data/api/status_codes.dart';
import 'package:zimsmobileapp/data/api/zims_api.dart';
import 'package:zimsmobileapp/data/server/requests/requests.dart';
import 'package:zimsmobileapp/data/server/responses/responses.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

class ZimsClient with DocumentTypeValue implements ZimsApi {
  static const BASE_URL = "https://mobileapizims.gsb.gov.zm";

  static const LOGIN_URL = "$BASE_URL/Account/Login";

  static const PERMIT_DATA_URL = "$BASE_URL/Citizen/Data";

  static const PERMIT_PHOTO_URL = "$BASE_URL/Citizen/DocumentPhoto";

  static const Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json'
  };

  static const NO_INTERNET_CONNECTION = "No Internet connection";

  final http.Client httpClient;

  ZimsClient({@required this.httpClient});

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final body = jsonEncode(request);

      final response =
          await httpClient.post(LOGIN_URL, body: body, headers: requestHeaders);

      final responseJson = _returnResponse(response);

      return LoginResponse.fromJson(responseJson);
    } on SocketException {
      throw FetchDataException(NO_INTERNET_CONNECTION);
    }
  }

  @override
  Future<PermitDataResponse> getPermitData(
      String token, DocumentType documentType, String documentNumber) async {
    try {
      Map<String, String> queryParameters =
          _createDocumentParams(documentType, documentNumber);

      var uri = Uri.parse(PERMIT_DATA_URL);
      uri = uri.replace(queryParameters: queryParameters);

      final response =
          await httpClient.get(uri, headers: _getHeadersWithToken(token));

      final responseJson = _returnResponse(response);

      return PermitDataResponse.fromJson(responseJson);
    } on SocketException {
      throw FetchDataException(NO_INTERNET_CONNECTION);
    }
  }

  @override
  Future<PermitPhotoResponse> getPermitPhoto(
      String token, DocumentType documentType, String documentNumber) async {
    try {
      Map<String, String> queryParameters =
          _createDocumentParams(documentType, documentNumber);

      var uri = Uri.parse(PERMIT_PHOTO_URL);
      uri = uri.replace(queryParameters: queryParameters);

      final response =
          await httpClient.get(uri, headers: _getHeadersWithToken(token));

      return PermitPhotoResponse.fromResponse(response);
    } on SocketException {
      throw FetchDataException(NO_INTERNET_CONNECTION);
    }
  }

  Map<String, String> _createDocumentParams(
      DocumentType documentType, String documentNumber) {
    Map<String, String> queryParameters = {
      'documentType': getDocumentTypeValue(documentType).toString(),
      'documentNumber': documentNumber
    };

    return queryParameters;
  }

  Map<String, String> _getHeadersWithToken(String token) {
    Map<String, String> headers = {}..addAll(requestHeaders);
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case StatusCodes.SUCCESS:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case StatusCodes.BAD_REQUEST:
        throw BadRequestException(response.body.toString());
      case StatusCodes.UNAUTHORIZED:
      case StatusCodes.FORBIDDEN:
        throw UnauthorizedException(response.body.toString());
      case StatusCodes.NOT_FOUND:
        throw NotFoundException(response.body.toString());
      case StatusCodes.INTERNAL_SERVER_ERROR:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
