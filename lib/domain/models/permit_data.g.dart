// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permit_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PermitDataAdapter extends TypeAdapter<PermitData> {
  @override
  final typeId = 0;

  @override
  PermitData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PermitData(
      documentStatus: fields[0] as String,
      documentType: fields[1] as String,
      documentNumber: fields[2] as String,
      permitType: fields[3] as String,
      permitNumber: fields[4] as String,
      validFrom: fields[5] as DateTime,
      validUntil: fields[6] as DateTime,
      issuedBy: fields[7] as String,
      color: fields[8] as String,
      passportNumber: fields[9] as String,
      country: fields[10] as String,
      issuedAt: fields[11] as String,
      issuedOn: fields[12] as DateTime,
      expiresOn: fields[13] as DateTime,
      firstName: fields[14] as String,
      lastName: fields[15] as String,
      middleName: fields[16] as String,
      fileNumber: fields[17] as String,
      gender: fields[18] as String,
      comment: fields[19] as String,
      timeScanned: fields[20] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PermitData obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.documentStatus)
      ..writeByte(1)
      ..write(obj.documentType)
      ..writeByte(2)
      ..write(obj.documentNumber)
      ..writeByte(3)
      ..write(obj.permitType)
      ..writeByte(4)
      ..write(obj.permitNumber)
      ..writeByte(5)
      ..write(obj.validFrom)
      ..writeByte(6)
      ..write(obj.validUntil)
      ..writeByte(7)
      ..write(obj.issuedBy)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.passportNumber)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.issuedAt)
      ..writeByte(12)
      ..write(obj.issuedOn)
      ..writeByte(13)
      ..write(obj.expiresOn)
      ..writeByte(14)
      ..write(obj.firstName)
      ..writeByte(15)
      ..write(obj.lastName)
      ..writeByte(16)
      ..write(obj.middleName)
      ..writeByte(17)
      ..write(obj.fileNumber)
      ..writeByte(18)
      ..write(obj.gender)
      ..writeByte(19)
      ..write(obj.comment)
      ..writeByte(20)
      ..write(obj.timeScanned);
  }
}
