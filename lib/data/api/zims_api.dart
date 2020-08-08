import 'package:zimsmobileapp/data/server/requests/requests.dart';
import 'package:zimsmobileapp/data/server/responses/responses.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class ZimsApi {
  Future<LoginResponse> login(LoginRequest request);

  Future<PermitDataResponse> getPermitData(
      String token, DocumentType documentType, String documentNumber);

  Future<PermitPhotoResponse> getPermitPhoto(
      String token, DocumentType documentType, String documentNumber);
}
