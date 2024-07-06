// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PingDataAdapter extends TypeAdapter<PingData> {
  @override
  final int typeId = 9;

  @override
  PingData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PingData(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      messageId: fields[2] as int,
      messageText: fields[3] as String,
      sentBy: fields[4] as SentBy,
      multiResponse: fields[5] as bool,
      priority: fields[6] as int,
      totalAck: fields[7] as int,
      totalNotAck: fields[8] as int,
      createdBy: fields[9] as int,
      createdOn: fields[10] as DateTime,
      attachmentCount: fields[11] as int,
      hasReply: fields[12] as int,
      acknowledgedFlag: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PingData obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.messageId)
      ..writeByte(3)
      ..write(obj.messageText)
      ..writeByte(4)
      ..write(obj.sentBy)
      ..writeByte(5)
      ..write(obj.multiResponse)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.totalAck)
      ..writeByte(8)
      ..write(obj.totalNotAck)
      ..writeByte(9)
      ..write(obj.createdBy)
      ..writeByte(10)
      ..write(obj.createdOn)
      ..writeByte(11)
      ..write(obj.attachmentCount)
      ..writeByte(12)
      ..write(obj.hasReply)
      ..writeByte(13)
      ..write(obj.acknowledgedFlag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PingDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PingResponse _$PingResponseFromJson(Map<String, dynamic> json) => PingResponse(
      data: (json['Data'] as List<dynamic>)
          .map((e) => PingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['ErrorCode'] as String,
    );

Map<String, dynamic> _$PingResponseToJson(PingResponse instance) =>
    <String, dynamic>{
      'Data': instance.data,
      'ErrorCode': instance.errorCode,
    };

PingData _$PingDataFromJson(Map<String, dynamic> json) => PingData(
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      messageId: json['MessageId'] as int,
      messageText: json['MessageText'] as String,
      sentBy: SentBy.fromJson(json['SentBy'] as Map<String, dynamic>),
      multiResponse: json['MultiResponse'] as bool,
      priority: json['Priority'] as int,
      totalAck: json['TotalAck'] as int,
      totalNotAck: json['TotalNotAck'] as int,
      createdBy: json['CreatedBy'] as int,
      createdOn: DateTime.parse(json['CreatedOn'] as String),
      attachmentCount: json['AttachmentCount'] as int,
      hasReply: json['HasReply'] as int,
      acknowledgedFlag: json['AcknowledgedFlag'] as int,
    );

Map<String, dynamic> _$PingDataToJson(PingData instance) => <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MessageId': instance.messageId,
      'MessageText': instance.messageText,
      'SentBy': instance.sentBy,
      'MultiResponse': instance.multiResponse,
      'Priority': instance.priority,
      'TotalAck': instance.totalAck,
      'TotalNotAck': instance.totalNotAck,
      'CreatedBy': instance.createdBy,
      'CreatedOn': instance.createdOn.toIso8601String(),
      'AttachmentCount': instance.attachmentCount,
      'HasReply': instance.hasReply,
      'AcknowledgedFlag': instance.acknowledgedFlag,
    };

SentBy _$SentByFromJson(Map<String, dynamic> json) => SentBy(
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
    );

Map<String, dynamic> _$SentByToJson(SentBy instance) => <String, dynamic>{
      'Firstname': instance.firstname,
      'Lastname': instance.lastname,
    };
