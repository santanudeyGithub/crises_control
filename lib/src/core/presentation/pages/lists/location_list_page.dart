// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
//import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: library_prefixes
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;
import 'package:google_fonts/google_fonts.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({
    super.key,
    required this.selectedLocations,
    required this.locationListType,
  });
  final List<LocationsData> selectedLocations;
  final LocationListType locationListType;

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  final List<LocationsData> _selectedLocations = [];
  List<LocationsData> _allLocation = [];
  List<LocationsData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  final _loadingOverlay = CCLoadingOverlay();
  bool _isChecked = false; // State for checkbox
  bool _isDisabled = false;

  void _onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
      if (_isChecked) {
        _isDisabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context);
    return Scaffold(
      appBar: //PreferredSize(
          // preferredSize: const Size.fromHeight(155.0),
          _getAppBar(widget.locationListType, context),
      //), //_getAppBar(locationListType, context),
      body: Stack(
        children: [
          Positioned(
            top: 0, // Adjust to control the overlap

            bottom: 0,
            child: _LocationListBody(widget.selectedLocations),
          ),
        ],
      ),
    );
  }

  _getAppBar(LocationListType locationListType, BuildContext context) {
    final language = AppLocalizations.of(context);
    if (locationListType == LocationListType.affected) {
      return AppBar(
        title: Text(language!.label_affected_location),
      );
    } else if (locationListType == LocationListType.impacted) {
      return PreferredSize(
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
                padding: const EdgeInsets.only(left: 0, right: 15),
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
                language!.label_impacted_location,
                style: GoogleFonts.urbanist(color: Colors.white),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on, color: Colors.white)),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
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
      );
    } else {
      //LocationListType.toNotify
      // return AppBar(
      // title: Text(language!.label_locations_to_notify),
      // actions: [
      //   IconButton(onPressed: () {}, icon: const Icon(Icons.location_on))
      // ],
      // );
      return PreferredSize(
        preferredSize: const Size.fromHeight(260.0),
        child: Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 45,
          child: AppBar(
            elevation: 0.0,
            // leading: Container(),
            flexibleSpace: const Image(
              image: AssetImage('assets/images/img_group_10.png'),
              fit: BoxFit.cover,
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 0, right: 25),
                //   child: IconButton(
                //     icon: const Icon(
                //       Icons.arrow_back_rounded,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    language!.label_locations_to_notify,
                    style: GoogleFonts.urbanist(color: Colors.white),
                  ),
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(Icons.location_on, color: Colors.white)),

                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        //color: value ? Colors.blue : Colors.grey,
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 2.0,
                      ),
                      //color: value ? Colors.blue : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 20.0,
                      color: Color(0xff1E60AA),
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 50),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  // child: searchBar.SearchBar(
                  //   searchTextController: _searchTextController,
                  //   onClear: () {
                  //     setState(() {
                  //       _searchTextController.clear();
                  //     });
                  //   },
                  //   onChanged: (value) async {
                  //     await _onSearchTextChanged(value);
                  //   },
                  // ),
                  child: Row(
                    children: [
                      Expanded(
                        child: searchBar.SearchBar(
                          searchTextController: _searchTextController,
                          onClear: () {
                            setState(() {
                              _searchTextController.clear();
                              _onSearchTextChanged('');
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _onSearchTextChanged(value);
                            });
                          },
                        ),
                      ),
                      // Add any other widget you want to display in the same row
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image(
                          image:
                              AssetImage('assets/images/location_tracker.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allLocation.where(
        (value) {
          return (value.locationName
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              value.locationName.toLowerCase().contains(
                    text.toLowerCase(),
                  ));
        },
      ).toList();
    });
  }
}

class _LocationListBody extends StatefulWidget {
  const _LocationListBody(this.selectedLocations);
  final List<LocationsData> selectedLocations;

  @override
  State<_LocationListBody> createState() => _LocationListBodyState();
}

class _LocationListBodyState extends State<_LocationListBody> {
  final List<LocationsData> _selectedLocations = [];
  List<LocationsData> _allLocation = [];
  List<LocationsData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  final _loadingOverlay = CCLoadingOverlay();

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/L_T_Notify.png',
      'text': 'Weekend Crew',
      'checked': false
    },
  ];

  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    context.read<ListCubit>().loadLocations();
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
          //  searchTextController: _searchTextController,
          // onClear: () {
          //  setState(() {
          //   _searchTextController.clear();
          // });
          // },
          //  onChanged: (value) {
          //  setState(() {
          //_onSearchTextChanged(value);
          //  });
          // },
          //  ),
          BlocConsumer<ListCubit, ListState>(
            listener: (context, state) {
              _handleStateChanges(state, context);
            },
            builder: (context, state) {
              if (state is LocationsListLoaded) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    padding: const EdgeInsets.all(16.0),
                    width: 375,
                    height: 520,
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
                    // child: ListView.separated(
                    //   itemCount: _searchTextController.text.isNotEmpty
                    //       ? _searchResults.length
                    //       : state.locations.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     var location = _searchTextController.text.isNotEmpty
                    //         ? _searchResults[index]
                    //         : state.locations[index];
                    //     return ListTile(
                    //       title: Text(location.locationNameAndCount),
                    //       trailing: _selectedLocations.contains(location)
                    //           ? const Icon(
                    //               Icons.check,
                    //               color: Palette.primary,
                    //             )
                    //           : null,
                    //       onTap: () {
                    //         _handleLocationSelected(location);
                    //       },
                    //     );
                    //   },
                    //   separatorBuilder: (BuildContext context, int index) =>
                    //       const Divider(),
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ListView.builder(
                        itemCount: _searchTextController.text.isNotEmpty
                            ? _searchResults.length
                            : state.locations.length,
                        itemBuilder: (BuildContext context, int index) {
                          var location = _searchTextController.text.isNotEmpty
                              ? _searchResults[index]
                              : state.locations[index];
                          final item = items[index % items.length];
                          return ListTile(
                            // trailing: _selectedLocations.contains(location)
                            //     ? const Icon(
                            //         Icons.check,
                            //         color: Palette.primary,
                            //       )
                            //     : null,
                            onTap: () {
                              _handleLocationSelected(location);
                            },
                            leading: Image.asset(
                              items[index]['image']!,
                              height: 50,
                              width: 50,
                            ),
                            title: Text(location.locationNameAndCount),
                            trailing: CustomCheckbox(
                              value: items[index]['checked'],
                              // activeColor:
                              //     Colors.blue, // Color when the checkbox is active
                              // checkColor: Colors.white, // Color of the check mark
                              onChanged: (bool? value) {
                                setState(() {
                                  items[index]['checked'] = value!;
                                  selectAll =
                                      items.every((item) => item['checked']);
                                });
                              },
                            ),
                          );
                        },
                        // separatorBuilder: (BuildContext context, int index) =>
                        //     const Divider(),
                      ),
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
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffDDE6EC), // Text color
                elevation: 5, // Elevation
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Button border radius
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 165, vertical: 20),
              ),
              child: Text(
                'Done'.toUpperCase(),
                style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
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

    if (state is LocationsListLoaded) {
      _allLocation = state.locations;
    }
    if (state is ListError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
  }

  void _handleLocationSelected(LocationsData location) {
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

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allLocation.where(
        (value) {
          return (value.locationName
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              value.locationName.toLowerCase().contains(
                    text.toLowerCase(),
                  ));
        },
      ).toList();
    });
  }
}
