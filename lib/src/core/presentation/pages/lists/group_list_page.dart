// ignore_for_file: library_prefixes, deprecated_member_use

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;
import 'package:google_fonts/google_fonts.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({
    super.key,
    required this.selectedGroups,
  });
  final List<GroupData> selectedGroups;

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  final List<GroupData> _selectedGroups = [];
  List<GroupData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  List<GroupData> _allGroups = [];
  final CCLoadingOverlay _ccLoadingOverlay = CCLoadingOverlay();

  bool isChecked = false;
  bool _isDisabled = false;

  bool isMale = true;
  bool isIncidentScreen = true;
  bool isSignupScreen = false;
  bool isRememberMe = false;
  bool selectAll = false;

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'Berlin Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
    {
      'image': 'assets/images/people_img.png',
      'text': 'SOS Crew',
      'checked': false
    },
  ];

  bool showSearchBox = true;

  void _onChanged(String query) {
    // Implement your search logic here
    print('Searching for: $query');
  }

  @override
  void initState() {
    super.initState();
    context.read<ListCubit>().loadGroups();
    _selectedGroups.addAll(widget.selectedGroups);
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.label_groups_to_notify,
              actionIcon: Container(
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
          ),
          Positioned(
            top: 120, // Adjust to control the overlap
            left: 8,
            right: 10,
            bottom: 30, // Adjust to make space for the button at the bottom
            child: Column(
              children: [
                // searchBar.SearchBar(
                //   searchTextController: _searchTextController,
                //   onClear: () {
                //     setState(() {
                //       _searchTextController.clear();
                //       _onSearchTextChanged('');
                //     });
                //   },
                //   onChanged: (value) {
                //     setState(() {
                //       _onSearchTextChanged(value);
                //     });
                //   },
                // ),

                // Expanded(
                //   child: WillPopScope(
                //     onWillPop: () async {
                //       Navigator.pop(context, _selectedGroups);
                //       return true;
                //     },
                //     child: BlocConsumer<ListCubit, ListState>(
                //       listener: (context, state) {
                //         handleStateChanges(state, context);
                //       },
                //       builder: (context, state) {
                //         if (state is GroupsListLoaded) {
                //           return Container(
                //             margin: const EdgeInsets.only(
                //                 top: 20,
                //                 right: 5,
                //                 left: 5), // Adjust this to position the box
                //             padding: const EdgeInsets.all(8.0),
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(20.0),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.withOpacity(0.5),
                //                   spreadRadius: 2,
                //                   blurRadius: 7,
                //                   offset: const Offset(
                //                       0, 3), // changes position of shadow
                //                 ),
                //               ],
                //             ),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(8),
                //               child: ListView.builder(
                //                 itemCount: _searchTextController.text.isNotEmpty
                //                     ? _searchResults.length
                //                     : _allGroups.length,
                //                 itemBuilder: (context, index) {
                //                   var group =
                //                       _searchTextController.text.isNotEmpty
                //                           ? _searchResults[index]
                //                           : _allGroups[index];
                //                   var isSelected =
                //                       _selectedGroups.contains(group);
                //                   final item = items[index % items.length];
                //                   return ListTile(
                //                     selected: isSelected,
                //                     onTap: () {
                //                       setState(() {
                //                         if (isSelected) {
                //                           _selectedGroups.remove(group);
                //                         } else {
                //                           _selectedGroups.add(group);
                //                         }
                //                       });
                //                     },
                //                     leading: Image.asset(
                //                       items[index]['image']!,
                //                       height: 50,
                //                       width: 50,
                //                     ),
                //                     title: Text(group.groupNameAndCount),

                //                     trailing: CustomCheckbox(
                //                       value: items[index]['checked'],
                //                       // activeColor:
                //                       //     Colors.blue, // Color when the checkbox is active
                //                       // checkColor: Colors.white, // Color of the check mark
                //                       onChanged: (bool? value) {
                //                         setState(() {
                //                           items[index]['checked'] = value!;
                //                           selectAll = items
                //                               .every((item) => item['checked']);
                //                         });
                //                       },
                //                     ),
                //                     // trailing: SvgPicture.asset(
                //                     // 'assets/images/img_checkmark_blue_gray_100.svg'),
                //                   );
                //                 },
                //               ),
                //             ),
                //           );
                //         }
                //         if (state is EmptyState) {
                //           return const EmptyState(
                //               text: 'No groups', icon: null);
                //         }
                //         return Container();
                //       },
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      // Image(
                      //   image: AssetImage('assets/images/location_tracker.png'),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context, _selectedGroups);
                      return true;
                    },
                    child: BlocConsumer<ListCubit, ListState>(
                      listener: (context, state) {
                        handleStateChanges(state, context);
                      },
                      builder: (context, state) {
                        if (state is GroupsListLoaded) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 20,
                                right: 5,
                                left: 5), // Adjust this to position the box
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ListView.builder(
                                itemCount: _searchTextController.text.isNotEmpty
                                    ? _searchResults.length
                                    : _allGroups.length,
                                itemBuilder: (context, index) {
                                  var group =
                                      _searchTextController.text.isNotEmpty
                                          ? _searchResults[index]
                                          : _allGroups[index];
                                  var isSelected =
                                      _selectedGroups.contains(group);
                                  final item = items[index % items.length];
                                  return ListTile(
                                    selected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedGroups.remove(group);
                                        } else {
                                          _selectedGroups.add(group);
                                        }
                                      });
                                    },
                                    leading: Image.asset(
                                      items[index]['image']!,
                                      height: 50,
                                      width: 50,
                                    ),
                                    title: Text(group.groupNameAndCount),

                                    trailing: CustomCheckbox(
                                      value: items[index]['checked'],
                                      // activeColor:
                                      //     Colors.blue, // Color when the checkbox is active
                                      // checkColor: Colors.white, // Color of the check mark
                                      onChanged: (bool? value) {
                                        setState(() {
                                          items[index]['checked'] = value!;
                                          selectAll = items
                                              .every((item) => item['checked']);
                                        });
                                      },
                                    ),
                                    // trailing: SvgPicture.asset(
                                    // 'assets/images/img_checkmark_blue_gray_100.svg'),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        if (state is EmptyState) {
                          return const EmptyState(
                              text: 'No groups', icon: null);
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: Padding(
              padding: const EdgeInsets.only(top: 45),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedGroups);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xffDDE6EC), // Text color
                  elevation: 5, // Elevation
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Button border radius
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                ),
                child: Text(
                  'Done'.toUpperCase(),
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3A3A3A),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleStateChanges(ListState state, BuildContext context) {
    if (state is ListError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
    if (state is ListLoading) {
      _ccLoadingOverlay.show(context);
    } else {
      _ccLoadingOverlay.hide();
    }
    if (state is GroupsListLoaded) {
      _allGroups = state.groups;
    }
  }

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allGroups
          .where(
            (value) =>
                (value.groupName.toLowerCase().contains(text.toLowerCase()) ||
                    value.groupName.toLowerCase().contains(text.toLowerCase())),
          )
          .toList();
    });
  }
}
