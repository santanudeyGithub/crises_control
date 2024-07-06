// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:async';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/google_maps_data.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/incident/cubits/map_position_picker/map_position_picker_cubit.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart' as searchBar;

class MapPositionPickerPage extends StatefulWidget {
  const MapPositionPickerPage({super.key});

  @override
  State<MapPositionPickerPage> createState() => _MapPositionPickerPageState();
}

class _MapPositionPickerPageState extends State<MapPositionPickerPage> {
  final TextEditingController _searchTextController = TextEditingController();

  GoogleMapController? _mapController;
  CameraPosition? _initialCameraPosition;
  List<Marker> _marker = [];
  List<Prediction> _predictions = [];
  Prediction? _selectedPrediction;
  AffectedLocationsData? _returnData;
  bool _skipOnSearchTextChanged = false;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(0, 0),
      zoom: FrontEndConstants.googleMapDefaultZoomLevel,
    );
    context.read<MapPositionPickerCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _returnData);
        return true;
      },
      child: BlocConsumer<MapPositionPickerCubit, MapPositionPickerState>(
        listener: (context, state) {
          _handleStateChanges(state, context);
        },
        builder: (context, state) {
          return Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              initialCameraPosition: _initialCameraPosition!,
              markers: Set.from(_marker),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              onTap: _handleMapTap,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: const Color(0xFFFFFFFF),
                    child: Column(
                      children: [
                        //Searchbar
                        Align(
                          alignment: Alignment.topCenter,
                          child: searchBar.SearchBar(
                            searchTextController: _searchTextController,
                            onClear: () {
                              setState(() {
                                _searchTextController.clear();
                                _predictions = [];
                              });
                            },
                            onChanged: (value) async {
                              await _onSearchTextChanged(value);
                            },
                          ),
                        ),
                        if (_predictions.isNotEmpty) ...[
                          //SearchList
                          Align(
                              alignment: Alignment.topCenter,
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _predictions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    tileColor: Colors.white,
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                          _predictions[index].description!),
                                    ),
                                    onTap: () async {
                                      await context
                                          .read<MapPositionPickerCubit>()
                                          .loadPlaceDetail(_predictions[index]);
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                },
                              )),
                        ]
                      ],
                    ),
                  ),
                  //Buttons
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xffD3D4DE), 
                              foregroundColor: const Color(
                                  0xff606162), 
                            ),
                            child: const Text(
                              "Cancel", 
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_selectedPrediction == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) =>                                      
                                      const CCAlertDialog(
                                    title: "No Location Selected",
                                    description: "You must select a location",
                                    actions: [
                                      OkAlertButton(),
                                    ],
                                  ),
                                );
                              } else {
                                setState(() {
                                  _returnData = AffectedLocationsData(
                                    locationId: 0,
                                    locationName: _selectedPrediction!.name!,
                                    address:
                                        _selectedPrediction!.formattedAddress!,
                                    lat: _selectedPrediction!.lat.toString(),
                                    lng: _selectedPrediction!.lng.toString(),
                                    locationType: "AFFECTED",
                                  );
                                });
                                Navigator.pop(context, _returnData);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.primary,
                            ),
                            child: const Text(
                              "Select", 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    ));
  }

  Future<void> _handleMapTap(LatLng tappedPoint) async {
    _createMarker(tappedPoint);
    await context
        .read<MapPositionPickerCubit>()
        .loadGeocode(tappedPoint.latitude, tappedPoint.longitude);
  }

  void _createMarker(LatLng tappedPoint) {
    setState(() {
      _marker = [];
      _marker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        // draggable: true,
        // onDragEnd: (dragEndPosition) {
        //   log(dragEndPosition.toString());
        // }
      ));
    });
  }

  void _moveCameraToMarker() {
    if (_marker.isNotEmpty) {
      var position = _marker.first.position;
      var cameraUpdate = CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: FrontEndConstants.googleMapDefaultZoomLevel,
        ),
      );
      _mapController?.animateCamera(cameraUpdate);
    }
  }

  Future<void> _onSearchTextChanged(String text) async {
    EasyDebounce.debounce('search-location-debouncer',
        const Duration(milliseconds: FrontEndConstants.debouncerDuration),
        () async {
      if (text.isEmpty) {
        setState(() {
          _predictions = [];
        });
      }
      if (!_skipOnSearchTextChanged && text.isNotEmpty) {
        await context.read<MapPositionPickerCubit>().loadAutocomplete(text);
      }
    });
  }

  void _handleStateChanges(MapPositionPickerState state, BuildContext context) {
    if (state is MapPositionPickerStateInitialLoaded) {
      var position = state.currentLocation;
      var cameraUpdate = CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: FrontEndConstants.googleMapDefaultZoomLevel,
        ),
      );
      _mapController?.moveCamera(cameraUpdate);
    }

    if (state is MapPositionPickerCubitGeocodeSuccess) {
      _skipOnSearchTextChanged = true;
      _searchTextController.text = state.addressTuple.value1;
      setState(() {
        _predictions = [];
        _selectedPrediction = Prediction(
          description: state.addressTuple.value1,
          lat: _marker.first.position.latitude,
          lng: _marker.first.position.longitude,
          name: state.addressTuple.value2,
          formattedAddress: state.addressTuple.value1,
        );
      });
      _skipOnSearchTextChanged = false;
    }

    if (state is MapPositionPickerStateAutocompleteSuccess) {
      setState(() {
        _predictions = state.predictions;
      });
    }

    if (state is MapPositionPickerStatePlaceDetailSuccess) {
      setState(() {
        _predictions = [];
        _selectedPrediction = state.prediction;
        _createMarker(LatLng(state.prediction.lat!, state.prediction.lng!));
        _moveCameraToMarker();
      });
    }

    //Errors
    if (state is MapPositionPickerStateGeocodeFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
    if (state is MapPositionPickerStateAutocompleteFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
    if (state is MapPositionPickerStatePlaceDetailFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
  }
}
