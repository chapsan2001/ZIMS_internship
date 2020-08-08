import 'package:barcode_scan/barcode_scan.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/repositories/qr_scan_repository.dart';

class QrScanService implements QrScanRepository {
  @override
  Future<String> scan() async {
    final result = await BarcodeScanner.scan();

    switch (result.type) {
      case ResultType.Cancelled:
        throw QrScanCancelledException();
      case ResultType.Error:
        throw QrScanFailedException();
      default:
        return result.rawContent;
    }
  }
}
