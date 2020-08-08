import 'package:zimsmobileapp/domain/models/models.dart';

abstract class PermitRepository {
  Future<PermitData> getPermitData(
      DocumentType documentType, String documentNumber);

  Future<PermitPhoto> getPermitPhoto(
      DocumentType documentType, String documentNumber);
}
