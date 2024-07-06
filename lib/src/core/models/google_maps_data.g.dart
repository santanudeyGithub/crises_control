// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_maps_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressInfo _$AddressInfoFromJson(Map<String, dynamic> json) => AddressInfo(
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipcode: json['zipcode'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AddressInfoToJson(AddressInfo instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zipcode': instance.zipcode,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

PlacesMatchedSubstring _$PlacesMatchedSubstringFromJson(
        Map<String, dynamic> json) =>
    PlacesMatchedSubstring(
      length: json['length'] as int,
      offset: json['offset'] as int,
    );

Map<String, dynamic> _$PlacesMatchedSubstringToJson(
        PlacesMatchedSubstring instance) =>
    <String, dynamic>{
      'length': instance.length,
      'offset': instance.offset,
    };

PlacesTerm _$PlacesTermFromJson(Map<String, dynamic> json) => PlacesTerm(
      offset: json['offset'] as int,
      value: json['value'] as String,
    );

Map<String, dynamic> _$PlacesTermToJson(PlacesTerm instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
      id: json['id'] as String?,
      description: json['description'] as String?,
      matchedSubstrings: (json['matched_substrings'] as List<dynamic>?)
          ?.map(
              (e) => PlacesMatchedSubstring.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      terms: (json['terms'] as List<dynamic>?)
          ?.map((e) => PlacesTerm.fromJson(e as Map<String, dynamic>))
          .toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      name: json['name'] as String?,
      formattedAddress: json['formattedAddress'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'matched_substrings': instance.matchedSubstrings,
      'place_id': instance.placeId,
      'reference': instance.reference,
      'terms': instance.terms,
      'types': instance.types,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'formattedAddress': instance.formattedAddress,
      'icon': instance.icon,
    };

PlacesLocationPredictions _$PlacesLocationPredictionsFromJson(
        Map<String, dynamic> json) =>
    PlacesLocationPredictions(
      predictions: (json['predictions'] as List<dynamic>?)
          ?.map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PlacesLocationPredictionsToJson(
        PlacesLocationPredictions instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
      'status': instance.status,
    };
