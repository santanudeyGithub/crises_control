import 'package:crises_control/src/core/models/list_models/request/acknowledge_option_rq.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MessageResponse {
  MessageResponse({
    required this.data,
    required this.errorCode,
  });

  final List<AcknowledgeOption> data;
  final String errorCode;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AcknowledgeOption extends Equatable {
  const AcknowledgeOption({
    required this.responseId,
    required this.libResponseId,
    required this.companyId,
    required this.responseLabel,
    required this.description,
    required this.messageType,
    required this.isSafetyResponse,
    required this.safetyAckAction,
    required this.updatedOn,
    required this.updatedBy,
    required this.status,
  });

  final int responseId;
  final int libResponseId;
  final int companyId;
  final String responseLabel;
  final String description;
  final String messageType;
  final bool isSafetyResponse;
  final String safetyAckAction;
  final DateTime updatedOn;
  final int updatedBy;
  final int status;

  factory AcknowledgeOption.fromJson(Map<String, dynamic> json) =>
      _$AcknowledgeOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AcknowledgeOptionToJson(this);

  @override
  List<Object?> get props => [
        responseId,
        libResponseId,
        companyId,
        responseLabel,
        description,
        messageType,
        isSafetyResponse,
        safetyAckAction,
        updatedOn,
        updatedBy,
        status,
      ];

  AcknowledgeOptionRq toAcknowledgeOptionRq(int responseCode) {
    return AcknowledgeOptionRq(
      responseId: responseId,
      responseLabel: responseLabel,
      responseCode: responseCode,
    );
  }
}
