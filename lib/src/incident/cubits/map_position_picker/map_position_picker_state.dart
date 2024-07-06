part of 'map_position_picker_cubit.dart';

abstract class MapPositionPickerState extends Equatable {
  const MapPositionPickerState();
  @override
  List<Object?> get props => [];
}

class MapPositionPickerStateInitial extends MapPositionPickerState {}

class MapPositionPickerStateInitialLoaded extends MapPositionPickerState {
  const MapPositionPickerStateInitialLoaded(this.currentLocation);
  final LatLng currentLocation;
  @override
  List<Object?> get props => [currentLocation];
}

//Geocode
class MapPositionPickerStateGeocodeLoading extends MapPositionPickerState {}

class MapPositionPickerCubitGeocodeSuccess extends MapPositionPickerState {
  const MapPositionPickerCubitGeocodeSuccess(this.addressTuple);
  final Tuple2<String, String> addressTuple;
  @override
  List<Object?> get props => [addressTuple];
}

class MapPositionPickerStateGeocodeFailure extends MapPositionPickerState {
  const MapPositionPickerStateGeocodeFailure(this.error);
  final CCError error;
  @override
  List<Object?> get props => [error];
}

class MapPositionPickerStateAutocompleteLoading extends MapPositionPickerState {
}

class MapPositionPickerStateAutocompleteSuccess extends MapPositionPickerState {
  const MapPositionPickerStateAutocompleteSuccess(this.predictions);
  final List<Prediction> predictions;
  @override
  List<Object?> get props => [predictions];
}

class MapPositionPickerStateAutocompleteFailure extends MapPositionPickerState {
  const MapPositionPickerStateAutocompleteFailure(this.error);
  final CCError error;
  @override
  List<Object?> get props => [error];
}

class MapPositionPickerStatePlaceDetailLoading extends MapPositionPickerState {}

class MapPositionPickerStatePlaceDetailSuccess extends MapPositionPickerState {
  const MapPositionPickerStatePlaceDetailSuccess(this.prediction);
  final Prediction prediction;
  @override
  List<Object?> get props => [prediction];
}

class MapPositionPickerStatePlaceDetailFailure extends MapPositionPickerState {
  const MapPositionPickerStatePlaceDetailFailure(this.error);
  final CCError error;
  @override
  List<Object?> get props => [error];
}
