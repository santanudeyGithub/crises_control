// ignore_for_file: library_prefixes, use_super_parameters, deprecated_member_use

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;
import 'package:google_fonts/google_fonts.dart';

class AffectedLocationListPage extends StatefulWidget {
  AffectedLocationListPage({
    super.key,
    required this.selectedLocations,
  });
  final List<AffectedLocationsData> selectedLocations;

  @override
  State<AffectedLocationListPage> createState() =>
      _AffectedLocationListPageState();
}

class _AffectedLocationListPageState extends State<AffectedLocationListPage> {
  final GlobalKey<_AffectedLocationListBodyState> _key = GlobalKey();
  final List<AffectedLocationsData> _selectedLocations = [];
  List<AffectedLocationsData> _allLocation = [];
  List<AffectedLocationsData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  final _loadingOverlay = CCLoadingOverlay();

  @override
  void initState() {
    super.initState();
    context.read<ListCubit>().loadAffectedLocations();
    _selectedLocations.addAll(widget.selectedLocations);
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(240.0),
        child: AppBar(
          elevation: 0.0,
          leading: Container(),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/img_group_10.png'),
            fit: BoxFit.cover,
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 25),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Text(
                language!.label_affected_location,
                style: GoogleFonts.urbanist(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0, left: 56),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on, color: Colors.white)),
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: searchBar.SearchBar(
                  searchTextController: _searchTextController,
                  onClear: () {
                    setState(() {
                      _searchTextController.clear();
                    });
                  },
                  onChanged: (value) async {
                    await _onSearchTextChanged(value);
                  },
                ),
              ),
            ),
          ),
        ),
      ), //AppBar(
      // title: Text(language!.label_affected_location),
      // ),

      body: _AffectedLocationListBody(
          key: _key,
          selectedLocations: widget.selectedLocations,
          language: language),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit_location),
        onPressed: () async {
          var location = await Navigator.pushNamed(
                  context, RouteConstants.mapPositionPickerPage)
              as AffectedLocationsData?;
          if (location != null && location.address.isNotEmpty) {
            _key.currentState!._onAddLocation(location);
          }
        },
      ),
    );
  }

  void _handleStateChanges(ListState state, BuildContext context) {
    if (state is ListLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }

    if (state is AffectedLocationsListLoaded) {
      _allLocation = state.affectedLocations;
    }
    if (state is ListError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
  }

  Future<void> _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allLocation.where((value) {
        return (value.locationName.toLowerCase().contains(text.toLowerCase()));
      }).toList();
    });
  }

  void _handleLocationSelected(AffectedLocationsData location) {
    if (_selectedLocations.contains(location)) {
      setState(() {
        _selectedLocations.remove(location);
      });
    } else {
      setState(() {
        _selectedLocations.add(location);
      });
    }
  }
}

class _AffectedLocationListBody extends StatefulWidget {
  const _AffectedLocationListBody(
      {Key? key, required this.selectedLocations, required this.language})
      : super(key: key);
  final List<AffectedLocationsData> selectedLocations;
  final AppLocalizations language;

  @override
  State<_AffectedLocationListBody> createState() =>
      _AffectedLocationListBodyState();
}

class _AffectedLocationListBodyState extends State<_AffectedLocationListBody> {
  final List<AffectedLocationsData> _selectedLocations = [];
  List<AffectedLocationsData> _allLocation = [];
  List<AffectedLocationsData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  final _loadingOverlay = CCLoadingOverlay();

  @override
  void initState() {
    super.initState();
    context.read<ListCubit>().loadAffectedLocations();
    _selectedLocations.addAll(widget.selectedLocations);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _selectedLocations);
        return true;
      },
      child: Column(
        children: [
          //searchBar.SearchBar(
          // searchTextController: _searchTextController,
          //  onClear: () {
          //  setState(() {
          // _searchTextController.clear();
          //  });
          //  },
          //onChanged: (value) async {
          //   await _onSearchTextChanged(value);
          // },
          // ),
          BlocConsumer<ListCubit, ListState>(
            listener: (context, state) {
              _handleStateChanges(state, context);
            },
            builder: (context, state) {
              if (state is AffectedLocationsListLoaded) {
                return Container(
                  height: 400,
                  width: 378,
                  margin: const EdgeInsets.only(
                      top: 25,
                      bottom: 0,
                      left: 15), // Adjust this to position the box
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: ListView.separated(
                      itemCount: _searchTextController.text.isNotEmpty
                          ? _searchResults.length
                          : state.affectedLocations.length,
                      itemBuilder: (BuildContext context, int index) {
                        var location = _searchTextController.text.isNotEmpty
                            ? _searchResults[index]
                            : state.affectedLocations[index];
                        return ListTile(
                          title: Text(location.locationName),
                          trailing: _selectedLocations.contains(location)
                              ? const Icon(
                                  Icons.check,
                                  color: Palette.primary,
                                )
                              : null,
                          onTap: () {
                            _handleLocationSelected(location);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                );
              }
              if (state is EmptyList) {
                return const EmptyState(text: 'No Locations', icon: null);
              }
              return Container();
            },
          ),
          // _NewLocationButton(language: widget.language),
        ],
      ),
    );
  }

  void _handleStateChanges(ListState state, BuildContext context) {
    if (state is ListLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }

    if (state is AffectedLocationsListLoaded) {
      _allLocation = state.affectedLocations;
    }
    if (state is ListError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
  }

  void _handleLocationSelected(AffectedLocationsData location) {
    if (_selectedLocations.contains(location)) {
      setState(() {
        _selectedLocations.remove(location);
      });
    } else {
      setState(() {
        _selectedLocations.add(location);
      });
    }
  }

  Future<void> _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allLocation.where((value) {
        return (value.locationName.toLowerCase().contains(text.toLowerCase()));
      }).toList();
    });
  }

  void _onAddLocation(AffectedLocationsData location) {
    setState(() {
      _allLocation.insert(0, location);
      _selectedLocations.insert(0, location);
    });
  }
}
