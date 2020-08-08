import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:zimsmobileapp/data/api/status_codes.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';

class PermitPhotoResponse {
  static const IMAGE_CONTENT_TYPE_PREFIX = "image";

  final Uint8List bytes;

  PermitPhotoResponse({this.bytes});

  factory PermitPhotoResponse.fromResponse(http.Response response) {
    if (_isImageResponse(response)) {
      return PermitPhotoResponse(bytes: response.bodyBytes);
    } else {
      final json = _returnResponseJson(response);

      final errorResponse = _PermitPhotoErrorResponse.fromJson(json);

      throwResponseError(errorResponse);

      return null;
    }
  }

  static bool _isImageResponse(http.Response response) {
    final contentType = response.headers[HttpHeaders.contentTypeHeader];

    return response.statusCode == StatusCodes.SUCCESS &&
        contentType.contains(IMAGE_CONTENT_TYPE_PREFIX);
  }

  static dynamic _returnResponseJson(http.Response response) {
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

  static throwResponseError(_PermitPhotoErrorResponse errorResponse) {
    switch (errorResponse.statusCode) {
      case StatusCodes.BAD_REQUEST:
        throw BadRequestException(errorResponse.value);
      case StatusCodes.UNAUTHORIZED:
      case StatusCodes.FORBIDDEN:
        throw UnauthorizedException(errorResponse.value);
      case StatusCodes.NOT_FOUND:
        throw NotFoundException(errorResponse.value);
      case StatusCodes.INTERNAL_SERVER_ERROR:
        throw ServerErrorException(errorResponse.value);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${errorResponse.statusCode}');
    }
  }
}

class _PermitPhotoErrorResponse {
  final String value;
  final int statusCode;

  _PermitPhotoErrorResponse({this.value, this.statusCode});

  factory _PermitPhotoErrorResponse.fromJson(dynamic json) {
    return _PermitPhotoErrorResponse(
        value: json['value'], statusCode: json['statusCode']);
  }
}
