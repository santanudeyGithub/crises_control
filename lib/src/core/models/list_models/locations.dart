import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/models/created_by.dart';
import 'package:crises_control/src/core/models/list_models/request/message_obj_rq.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Locations {
  Locations({
    required this.data,
  });

  final List<LocationsData> data;

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LocationsData extends Equatable {
  const LocationsData({
    required this.locationId,
    required this.locationName,
    required this.lat,
    required this.long,
    required this.desc,
    required this.postCode,
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

  final int locationId;
  final String locationName;
  final String? lat;
  final String? long;
  final String desc;
  final String postCode;
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

  factory LocationsData.fromJson(Map<String, dynamic> json) =>
      _$LocationsDataFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsDataToJson(this);

  String get locationNameAndCount => '$locationName ($userCount)';
  bool get isDeleted => activeUserCount == 0;
  bool get isNotDeleted => activeUserCount > 0;

  @override
  List<Object?> get props => [
        locationId,
        locationName,
        lat,
        long,
        desc,
        postCode,
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
      sourceObjectPrimaryId: locationId,
    );
  }
}
