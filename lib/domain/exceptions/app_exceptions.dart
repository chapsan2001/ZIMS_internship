class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix : $_message";
  }

  String getPrefix() => _prefix;
}

// API exceptions
class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Bad Request");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "Unauthorized");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "Not Found");
}

class ServerErrorException extends AppException {
  ServerErrorException([message]) : super(message, "Internal Server Error");
}

class UnknownException extends AppException {
  UnknownException([String message]) : super(message, "Unknown error");
}

// QR scan exceptions
class QrScanCancelledException extends AppException {
  QrScanCancelledException([String message]) : super(message);
}

class QrScanFailedException extends AppException {
  QrScanFailedException([String message]) : super(message);
}
