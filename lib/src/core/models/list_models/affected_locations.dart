import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'affected_locations.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AffectedLocations {
  AffectedLocations({
    required this.data,
  });

  final List<AffectedLocationsData> data;

  factory AffectedLocations.fromJson(Map<String, dynamic> json) =>
      _$AffectedLocationsFromJson(json);
  Map<String, dynamic> toJson() => _$AffectedLocationsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AffectedLocationsData extends Equatable {
  const AffectedLocationsData({
    required this.locationId,
    required this.locationName,
    required this.address,
    required this.lat,
    required this.lng,
    required this.locationType,
    this.impactedLocationId,
  });

  @JsonKey(name: 'LocationID')
  final int locationId;
  final String locationName;
  final String address;
  final String? lat;
  final String? lng;
  final String locationType;
  @JsonKey(name: 'ImpactedLocationID')
  final int? impactedLocationId;

  factory AffectedLocationsData.fromJson(Map<String, dynamic> json) =>
      _$AffectedLocationsDataFromJson(json);
  Map<String, dynamic> toJson() => _$AffectedLocationsDataToJson(this);

  @override
  List<Object?> get props => [
        locationId,
        locationName,
        address,
        lat,
        lng,
        locationType,
        impactedLocationId,
      ];
}
