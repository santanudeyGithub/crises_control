// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crises_control_contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CrisesControlContactAdapter extends TypeAdapter<CrisesControlContact> {
  @override
  final int typeId = 5;

  @override
  CrisesControlContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CrisesControlContact(
      id: fields[0] as String,
      displayName: fields[1] as String,
      phoneNumbers: (fields[2] as List).cast<String>(),
      phoneContactLogoUrl: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CrisesControlContact obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.phoneNumbers)
      ..writeByte(3)
      ..write(obj.phoneContactLogoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrisesControlContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
