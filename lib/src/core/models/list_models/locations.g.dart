// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      data: (json['Data'] as List<dynamic>)
          .map((e) => LocationsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'Data': instance.data,
    };

LocationsData _$LocationsDataFromJson(Map<String, dynamic> json) =>
    LocationsData(
      locationId: json['LocationId'] as int,
      locationName: json['LocationName'] as String,
      lat: json['Lat'] as String?,
      long: json['Long'] as String?,
      desc: json['Desc'] as String,
      postCode: json['PostCode'] as String,
      status: json['Status'] as int,
      objectMappingId: json['ObjectMappingId'] as int,
      userCount: json['UserCount'] as int,
      activeUserCount: json['ActiveUserCount'] as int,
      userList: json['UserList'],
      createdByName:
          CreatedByName.fromJson(json['CreatedByName'] as Map<String, dynamic>),
      updatedByName: json['UpdatedByName'],
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      companyId: json['CompanyId'] as int,
      createdOn: DateTime.parse(json['CreatedOn'] as String),
      updatedOn: DateTime.parse(json['UpdatedOn'] as String),
    );

Map<String, dynamic> _$LocationsDataToJson(LocationsData instance) =>
    <String, dynamic>{
      'LocationId': instance.locationId,
      'LocationName': instance.locationName,
      'Lat': instance.lat,
      'Long': instance.long,
      'Desc': instance.desc,
      'PostCode': instance.postCode,
      'Status': instance.status,
      'ObjectMappingId': instance.objectMappingId,
      'UserCount': instance.userCount,
      'ActiveUserCount': instance.activeUserCount,
      'UserList': instance.userList,
      'CreatedByName': instance.createdByName,
      'UpdatedByName': instance.updatedByName,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'CompanyId': instance.companyId,
      'CreatedOn': instance.createdOn.toIso8601String(),
      'UpdatedOn': instance.updatedOn.toIso8601String(),
    };
