import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/models/list_models/request/message_obj_rq.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'groups.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Groups extends Equatable {
  const Groups({
    required this.data,
  });

  final List<GroupData> data;

  @override
  List<Object?> get props => [data];

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);
  Map<String, dynamic> toJson() => _$GroupsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class GroupData extends Equatable {
  const GroupData({
    required this.groupId,
    required this.groupName,
    required this.status,
    required this.objectMappingId,
    required this.userCount,
    required this.activeUserCount,
    required this.userList,
    required this.createdByName,
    required this.updatedByName,
    required this.firstName,
    required this.lastName,
    required this.companyId,
    required this.createdOn,
    required this.updatedOn,
  });

  final int groupId;
  final String groupName;
  final int status;
  final int objectMappingId;
  final int userCount;
  final int activeUserCount;
  final dynamic userList;
  final CreatedByName createdByName;
  final dynamic updatedByName;
  final String firstName;
  final String lastName;
  final int companyId;
  final DateTime createdOn;
  final DateTime updatedOn;

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);
  Map<String, dynamic> toJson() => _$GroupDataToJson(this);

  String get groupNameAndCount => '$groupName ($userCount)';
  bool get isNotDeleted => activeUserCount > 0;
  bool get isDeleted => activeUserCount == 0;

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        status,
        objectMappingId,
        userCount,
        activeUserCount,
        userList,
        createdByName,
        updatedByName,
        firstName,
        lastName,
        companyId,
        createdOn,
        updatedOn,
      ];

  MessageObjRq toAcknowledgeOptionRq() {
    return MessageObjRq(
      objectMappingId: BackendConstants.objectMappingIdDepartment,
      sourceObjectPrimaryId: groupId,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CreatedByName extends Equatable {
  const CreatedByName({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory CreatedByName.fromJson(Map<String, dynamic> json) =>
      _$CreatedByNameFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByNameToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}
