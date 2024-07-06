// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affected_locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AffectedLocations _$AffectedLocationsFromJson(Map<String, dynamic> json) =>
    AffectedLocations(
      data: (json['Data'] as List<dynamic>)
          .map((e) => AffectedLocationsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AffectedLocationsToJson(AffectedLocations instance) =>
    <String, dynamic>{
      'Data': instance.data,
    };

AffectedLocationsData _$AffectedLocationsDataFromJson(
        Map<String, dynamic> json) =>
    AffectedLocationsData(
      locationId: json['LocationID'] as int,
      locationName: json['LocationName'] as String,
      address: json['Address'] as String,
      lat: json['Lat'] as String?,
      lng: json['Lng'] as String?,
      locationType: json['LocationType'] as String,
      impactedLocationId: json['ImpactedLocationID'] as int?,
    );

Map<String, dynamic> _$AffectedLocationsDataToJson(
        AffectedLocationsData instance) =>
    <String, dynamic>{
      'LocationID': instance.locationId,
      'LocationName': instance.locationName,
      'Address': instance.address,
      'Lat': instance.lat,
      'Lng': instance.lng,
      'LocationType': instance.locationType,
      'ImpactedLocationID': instance.impactedLocationId,
    };
