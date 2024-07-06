// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomePageCacheAdapter extends TypeAdapter<HomePageCache> {
  @override
  final int typeId = 3;

  @override
  HomePageCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomePageCache(
      (fields[1] as List).cast<HomeIconModel>(),
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HomePageCache obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.homeIcons)
      ..writeByte(2)
      ..write(obj.incidentCount)
      ..writeByte(3)
      ..write(obj.pingCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
