import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/google_maps_data.dart';
import 'package:crises_control/src/core/repository/google_maps_repository.dart';
import 'package:crises_control/src/core/services/location_service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_position_picker_state.dart';

class MapPositionPickerCubit extends Cubit<MapPositionPickerState> {
  MapPositionPickerCubit(this._googleMapsRepository, this._locationService)
      : super(MapPositionPickerStateInitial());

  final GoogleMapsRepository _googleMapsRepository;
  final LocationService _locationService;

  init() async {
    await Future.delayed(const Duration(milliseconds: 1));
    var currentLocation = await _locationService.getCurrentLocation();
    if (currentLocation != null) {
      emit(MapPositionPickerStateInitialLoaded(
          LatLng(currentLocation.latitude!, currentLocation.longitude!)));
    } else {
      emit(const MapPositionPickerStateInitialLoaded(LatLng(0, 0)));
    }
  }

  loadGeocode(double lat, double lng) async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(MapPositionPickerStateGeocodeLoading());
    if (isClosed) return;
    var result = await _googleMapsRepository.googleMapGeocode(lat, lng);
    result.fold(
      (error) => emit(
        MapPositionPickerStateGeocodeFailure(error),
      ),
      (addressTuple) {
        emit(MapPositionPickerCubitGeocodeSuccess(addressTuple));
      },
    );
  }

  loadAutocomplete(String searchInput) async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(MapPositionPickerStateAutocompleteLoading());
    var result =
        await _googleMapsRepository.googleMapPlaceAutocomplete(searchInput);
    if (isClosed) return;
    result.fold(
      (error) => emit(
        MapPositionPickerStateAutocompleteFailure(error),
      ),
      (predictions) {
        emit(MapPositionPickerStateAutocompleteSuccess(predictions));
      },
    );
  }

  loadPlaceDetail(Prediction prediction) async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(MapPositionPickerStatePlaceDetailLoading());
    var result =
        await _googleMapsRepository.googleMapPlaceDetail(prediction.placeId!);
    if (isClosed) return;
    result.fold(
      (error) => emit(
        MapPositionPickerStatePlaceDetailFailure(error),
      ),
      (prediction) {
        emit(MapPositionPickerStatePlaceDetailSuccess(prediction));
      },
    );
  }
}
