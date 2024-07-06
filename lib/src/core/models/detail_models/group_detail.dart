import 'package:crises_control/src/core/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_detail.g.dart';

@JsonSerializable()
class GroupDetail extends Equatable {
  const GroupDetail(
    this.groupId,
    this.groupName,
    this.status,
    this.objectMappingId,
    this.activeUserCount,
    this.users,
    this.createdByName,
    this.upatedByName,
    this.firstName,
    this.lastName,
    this.companyId,
    this.createdOn,
    this.updatedOn,
  );

  final int groupId;
  final String groupName;
  final int status;
  final int objectMappingId;
  final int activeUserCount;
  final List<User> users;
  final String createdByName;
  final String upatedByName;
  final String firstName;
  final String lastName;
  final int companyId;
  final DateTime createdOn;
  final DateTime updatedOn;

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        status,
        objectMappingId,
        activeUserCount,
        users,
        createdByName,
        upatedByName,
        firstName,
        lastName,
        companyId,
        createdOn,
        updatedOn,
      ];

  //JSON CONVERSION
  factory GroupDetail.fromJson(Map<String, dynamic> json) =>
      _$GroupDetailFromJson(json);
  Map<String, dynamic> toJson() => _$GroupDetailToJson(this);
}
