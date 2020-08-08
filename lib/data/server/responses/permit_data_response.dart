import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';

class PermitDataResponse {
  final VisaPermit visaPermit;
  final Passport passport;
  final Person person;
  final String comment;

  PermitDataResponse(
      {this.visaPermit, this.passport, this.person, this.comment});

  factory PermitDataResponse.fromJson(dynamic json) {
    final visaPermit = VisaPermit.fromJson(json['visaPermit']);

    if (!(visaPermit.isFound ?? false)) {
      throw NotFoundException("Permit data not found");
    }

    final passport = Passport.fromJson(json['passport']);
    final person = Person.fromJson(json['person']);
    final comment = json['comment'];

    return PermitDataResponse(
        visaPermit: visaPermit,
        passport: passport,
        person: person,
        comment: comment);
  }
}

class VisaPermit {
  final bool isFound;
  final String documentStatus;
  final String documentType;
  final String documentNumber;
  final String validFrom;
  final String validUntil;
  final String issuedBy;
  final String color;

  VisaPermit(
      {this.isFound,
      this.documentStatus,
      this.documentType,
      this.documentNumber,
      this.validFrom,
      this.validUntil,
      this.issuedBy,
      this.color});

  factory VisaPermit.fromJson(dynamic json) {
    return VisaPermit(
        isFound: json['isFound'],
        documentStatus: json['documentStatus'],
        documentType: json['documentType'],
        documentNumber: json['documentNumber'],
        validFrom: json['validFrom'],
        validUntil: json['validUntil'],
        issuedBy: json['issuedBy'],
        color: json['color']);
  }
}

class Passport {
  final String passportNumber;
  final String country;
  final String issuedAt;
  final String issuedOn;
  final String expiresOn;

  Passport(
      {this.passportNumber,
      this.country,
      this.issuedAt,
      this.issuedOn,
      this.expiresOn});

  factory Passport.fromJson(dynamic json) {
    return Passport(
        passportNumber: json['passportNumber'],
        country: json['country'],
        issuedAt: json['issuedAt'],
        issuedOn: json['issuedOn'],
        expiresOn: json['expiresOn']);
  }
}

class Person {
  final String firstName;
  final String lastName;
  final String middleName;
  final String fileNumber;
  final String gender;

  Person(
      {this.firstName,
      this.lastName,
      this.middleName,
      this.fileNumber,
      this.gender});

  factory Person.fromJson(dynamic json) {
    return Person(
        firstName: json['firstName'],
        lastName: json['lastName'],
        middleName: json['middleName'],
        fileNumber: json['fileNumber'],
        gender: json['gender']);
  }
}
