import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/data/api/zims_api.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/domain/models/permit_data.dart';
import 'package:zimsmobileapp/domain/repositories/permit_repository.dart';
import 'package:zimsmobileapp/domain/utils/app_preferences.dart';
import 'package:hive/hive.dart';

class PermitService implements PermitRepository {
  final AppPreferences appPreferences;
  final ZimsApi api;
  PermitService({@required this.appPreferences, this.api});

  @override
  Future<PermitData> getPermitData(
      DocumentType documentType, String documentNumber) {
    return appPreferences.getToken().then((token) async {
      final permitDataResponse =
          await api.getPermitData(token, documentType, documentNumber);

      PermitData pd = new PermitData(
          documentStatus: permitDataResponse.visaPermit.documentStatus,
          documentType: documentType.toString().split('.')[1],
          documentNumber: documentNumber,
          permitType: permitDataResponse.visaPermit.documentType,
          permitNumber: permitDataResponse.visaPermit.documentNumber,
          validFrom: _getDate(permitDataResponse.visaPermit.validFrom),
          validUntil: _getDate(permitDataResponse.visaPermit.validUntil),
          issuedBy: permitDataResponse.visaPermit.issuedBy,
          color: permitDataResponse.visaPermit.color,
          passportNumber: permitDataResponse.passport.passportNumber,
          country: permitDataResponse.passport.country,
          issuedAt: permitDataResponse.passport.issuedAt,
          issuedOn: _getDate(permitDataResponse.passport.issuedOn),
          expiresOn: _getDate(permitDataResponse.passport.expiresOn),
          firstName: permitDataResponse.person.firstName,
          lastName: permitDataResponse.person.lastName,
          middleName: permitDataResponse.person.middleName,
          fileNumber: permitDataResponse.person.fileNumber,
          gender: permitDataResponse.person.gender,
          comment: permitDataResponse.comment,
          timeScanned: DateTime.now());
      if (Hive.box('history').length < 10) {
        Hive.box('history').put(Hive.box('history').length+1, pd);
      } else {
        Hive.box('history').delete(1);
        for (int i = 1; i<10; i++) {
          Hive.box('history').put(i, Hive.box('history').get(i+1));
        }
        Hive.box('history').delete(10);
        Hive.box('history').put(Hive.box('history').length+1, pd);
      }
      return pd;
    });
  }

  @override
  Future<PermitPhoto> getPermitPhoto(
      DocumentType documentType, String documentNumber) {
    return appPreferences.getToken().then((token) async {
      final permitPhotoResponse =
          await api.getPermitPhoto(token, documentType, documentNumber);

      return PermitPhoto(bytes: permitPhotoResponse.bytes);
    });
  }

  DateTime _getDate(String date) {
    try {
      return date != null ? DateTime.parse(date) : null;
    } catch (e) {
      return null;
    }
  }
}
