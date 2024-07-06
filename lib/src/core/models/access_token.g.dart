// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccessTokenAdapter extends TypeAdapter<AccessToken> {
  @override
  final int typeId = 0;

  @override
  AccessToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccessToken(
      accessToken: fields[0] as String,
      tokenType: fields[1] as String,
      expiresIn: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AccessToken obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.tokenType)
      ..writeByte(2)
      ..write(obj.expiresIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
