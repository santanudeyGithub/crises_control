// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/google_maps_data.dart';
import 'package:crises_control/src/core/services/google_maps_rest_service.dart';
import 'package:dartz/dartz.dart';

class GoogleMapsRepository {
  GoogleMapsRepository(
    this._googleMapsRestService,
  );

  final GoogleMapsRestService _googleMapsRestService;

  Future<Either<CCError, Tuple2<String, String>>> googleMapGeocode(
      double lat, double lng) async {
    try {
      var response = await _googleMapsRestService.googleMapGeocode(lat, lng);
      String address = '';
      if (response["results"].isNotEmpty) {
        address = response["results"][0]["formatted_address"];
      }
      String addressFirstPart = mapAddressSplit(address);
      return Right(Tuple2(address, addressFirstPart));
    } on SocketException {
      return const Left(CCError.noConnectivityError);
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, List<Prediction>>> googleMapPlaceAutocomplete(
      String searchInput) async {
    try {
      var response =
          await _googleMapsRestService.googleMapPlaceAutocomplete(searchInput);
      var placesLocationPredictions =
          PlacesLocationPredictions.fromJson(response);
      if (placesLocationPredictions.status == "OK") {
        if (placesLocationPredictions.predictions == null)
          return const Right([]);
        return Right(placesLocationPredictions.predictions!);
      } else if (placesLocationPredictions.status == "ZERO_RESULTS") {
        return const Right([]);
      } else {
        return const Left(
            CCError()); 
      }
    } on SocketException {
      return const Left(CCError.noConnectivityError);
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, Prediction>> googleMapPlaceDetail(
      String placeId) async {
    try {
      var response = await _googleMapsRestService.googleMapPlaceDetail(placeId);
      if (response['status'] == "OK") {
        var name = response["result"]["name"] as String?;
        var formattedAddress =
            response["result"]["formatted_address"] as String?;
        var lat = response["result"]["geometry"]["location"]["lat"] as double?;
        var lng = response["result"]["geometry"]["location"]["lng"] as double?;
        var prediction = Prediction(
          name: name,
          formattedAddress: formattedAddress,
          lat: lat,
          lng: lng,
        );
        return Right(prediction);
      } else {
        return const Left(
            CCError()); 
      }
    } on SocketException {
      return const Left(CCError.noConnectivityError);
    } on Exception {
      return const Left(CCError());
    }
  }

  String mapAddressSplit(String? address) {
    if (address == null || address.isEmpty) return '';
    final split = address.split(',');
    return split[0];
  }
}
