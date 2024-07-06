import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'google_maps_data.g.dart';

@JsonSerializable()
class AddressInfo extends Equatable {
  const AddressInfo({
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.longitude,
    required this.latitude,
    
  });

  final String address;
  final String city;
  final String state;
  final String zipcode;
  final double longitude;
  final double latitude;

  factory AddressInfo.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoToJson(this);

  @override
  List<Object?> get props => [address, city, state, zipcode, longitude, latitude];
}

@JsonSerializable()
class PlacesMatchedSubstring extends Equatable {
  const PlacesMatchedSubstring({
    required this.length,
    required this.offset,
  });

  final int length;
  final int offset;

  factory PlacesMatchedSubstring.fromJson(Map<String, dynamic> json) =>
      _$PlacesMatchedSubstringFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesMatchedSubstringToJson(this);

  @override
  List<Object?> get props => [length, offset];
}

@JsonSerializable()
class PlacesTerm extends Equatable {
  const PlacesTerm({
    required this.offset,
    required this.value,
  });

  final int offset;
  final String value;

  factory PlacesTerm.fromJson(Map<String, dynamic> json) =>
      _$PlacesTermFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesTermToJson(this);

  @override
  List<Object?> get props => [offset, value];
}

@JsonSerializable()
class Prediction extends Equatable {
  const Prediction({
    this.id,
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.terms,
    this.types,
    this.lat,
    this.lng,
    this.name,
    this.formattedAddress,
    this.icon,
  });

  final String? id;
  final String? description;
  @JsonKey(name:'matched_substrings')
  final List<PlacesMatchedSubstring>? matchedSubstrings;
  @JsonKey(name:'place_id')
  final String? placeId;
  final String? reference;
  final List<PlacesTerm>? terms;
  final List<String>? types;
  final double? lat;
  final double? lng;
  final String? name;
  final String? formattedAddress;
  final String? icon;

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);

  @override
  List<Object?> get props => [
    id,
    description,
    matchedSubstrings,
    placeId,
    reference,
    terms,
    types,
    lat,
    lng,
    name,
    formattedAddress,
    icon,
  ];
}

@JsonSerializable()
class PlacesLocationPredictions extends Equatable {
  const PlacesLocationPredictions({
    this.predictions,
    required this.status,
  });

  final List<Prediction>? predictions;
  final String status;

  factory PlacesLocationPredictions.fromJson(Map<String, dynamic> json) =>
      _$PlacesLocationPredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesLocationPredictionsToJson(this);

  @override
  List<Object?> get props => [predictions, status];
}