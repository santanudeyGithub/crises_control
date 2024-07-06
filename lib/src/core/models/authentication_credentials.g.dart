// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_credentials.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationCredentialsAdapter
    extends TypeAdapter<AuthenticationCredentials> {
  @override
  final int typeId = 1;

  @override
  AuthenticationCredentials read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationCredentials(
      fields[0] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as bool,
      fields[5] as String,
      fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationCredentials obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.customerId)
      ..writeByte(4)
      ..write(obj.rememberMe)
      ..writeByte(5)
      ..write(obj.companyName)
      ..writeByte(6)
      ..write(obj.companyLogo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationCredentialsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
