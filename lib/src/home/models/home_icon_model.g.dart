// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_icon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeIconModelAdapter extends TypeAdapter<HomeIconModel> {
  @override
  final int typeId = 2;

  @override
  HomeIconModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeIconModel(
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HomeIconModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.homeItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeIconModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
