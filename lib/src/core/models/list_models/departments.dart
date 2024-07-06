import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/models/created_by.dart';
import 'package:crises_control/src/core/models/list_models/request/message_obj_rq.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'departments.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Departments extends Equatable {
  const Departments({
    required this.data,
  });

  final List<DepartmentsData> data;

  factory Departments.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentsToJson(this);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class DepartmentsData extends Equatable {
  const DepartmentsData({
    required this.departmentId,
    required this.departmentName,
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

  final int departmentId;
  final String departmentName;
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

  String get departmentNameWithCount => '$departmentName ($userCount)';
  factory DepartmentsData.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentsDataToJson(this);

  bool get isNotDeleted => activeUserCount > 0;
  bool get isDeleted => activeUserCount == 0;

  @override
  List<Object?> get props => [
        departmentId,
        departmentName,
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
      sourceObjectPrimaryId: departmentId,
    );
  }
}
