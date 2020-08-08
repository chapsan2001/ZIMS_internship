import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'permit_data.g.dart';

@HiveType(typeId: 0)
class PermitData extends Equatable {
  // Visa/Permit info
  @HiveField(0)
  final String documentStatus;
  @HiveField(1)
  final String documentType;
  @HiveField(2)
  final String documentNumber;
  @HiveField(3)
  final String permitType;
  @HiveField(4)
  final String permitNumber;
  @HiveField(5)
  final DateTime validFrom;
  @HiveField(6)
  final DateTime validUntil;
  @HiveField(7)
  final String issuedBy;
  @HiveField(8)
  final String color;

  // Passport info
  @HiveField(9)
  final String passportNumber;
  @HiveField(10)
  final String country;
  @HiveField(11)
  final String issuedAt;
  @HiveField(12)
  final DateTime issuedOn;
  @HiveField(13)
  final DateTime expiresOn;

  // Person info
  @HiveField(14)
  final String firstName;
  @HiveField(15)
  final String lastName;
  @HiveField(16)
  final String middleName;
  @HiveField(17)
  final String fileNumber;
  @HiveField(18)
  final String gender;

  @HiveField(19)
  final String comment;

  @HiveField(20)
  final DateTime timeScanned;

  PermitData(
      {this.documentStatus,
      this.documentType,
      this.documentNumber,
      this.permitType,
      this.permitNumber,
      this.validFrom,
      this.validUntil,
      this.issuedBy,
      this.color,
      this.passportNumber,
      this.country,
      this.issuedAt,
      this.issuedOn,
      this.expiresOn,
      this.firstName,
      this.lastName,
      this.middleName,
      this.fileNumber,
      this.gender,
      this.comment,
      this.timeScanned});

  @override
  List<Object> get props => [
        documentStatus,
        documentType,
        documentNumber,
        permitType,
        permitNumber,
        validFrom,
        validUntil,
        issuedBy,
        color,
        passportNumber,
        country,
        issuedAt,
        issuedOn,
        expiresOn,
        firstName,
        lastName,
        middleName,
        fileNumber,
        gender,
        comment,
        timeScanned
      ];
}
