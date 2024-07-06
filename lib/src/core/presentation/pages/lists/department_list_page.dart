// ignore_for_file: library_prefixes, deprecated_member_use

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;
import 'package:google_fonts/google_fonts.dart';

class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({
    super.key,
    required this.selectedDepartments,
  });
  final List<DepartmentsData> selectedDepartments;

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  final List<DepartmentsData> _selectedDepartments = [];
  List<DepartmentsData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  List<DepartmentsData> _allDepartments = [];

  bool isChecked = false;
  bool _isDisabled = false;

  bool isMale = true;
  bool isIncidentScreen = true;
  bool isSignupScreen = false;
  bool isRememberMe = false;
  bool selectAll = false;

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/depart_noty.png',
      'text': 'Weekend Crew',
      'checked': false
    },
    {
      'image': 'assets/images/depart_noty.png',
      'text': 'David Crew',
      'checked': false
    },
    {
      'image': 'assets/images/depart_noty.png',
      'text': 'Berlin Crew',
      'checked': false
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<ListCubit>().loadDepartments();
    _selectedDepartments.addAll(widget.selectedDepartments);
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
              title: language!.label_departments_to_notify,
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
                    color: Color.fromARGB(255, 254, 254, 255),
                  )),
            ),
          ),
          Positioned(
            top: 135, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50, // Adjust to make space for the button at the bottom
            child: Column(
              children: [
                searchBar.SearchBar(
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
                Expanded(
                  child: WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context, _selectedDepartments);
                      return true;
                    },
                    child: BlocConsumer<ListCubit, ListState>(
                      listener: (context, state) {
                        if (state is DepartmentsListLoaded) {
                          _allDepartments = state.departments;
                        }
                      },
                      builder: (context, state) {
                        if (state is DepartmentsListLoaded) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 50,
                                bottom: 32), // Adjust this to position the box
                            padding: const EdgeInsets.all(16.0),
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
                            // child: ListView.builder(
                            //   itemCount: _searchTextController.text.isNotEmpty
                            //       ? _searchResults.length
                            //       : state.departments.length,
                            //   itemBuilder: (context, index) {
                            //     var department =
                            //         _searchTextController.text.isNotEmpty
                            //             ? _searchResults[index]
                            //             : state.departments[index];
                            //     var isSelected =
                            //         _selectedDepartments.contains(department);
                            //     return SelectionListTile(
                            //       isSelected: isSelected,
                            //       onTap: () {
                            //         setState(() {
                            //           if (isSelected) {
                            //             _selectedDepartments.remove(department);
                            //           } else {
                            //             _selectedDepartments.add(department);
                            //           }
                            //         });
                            //       },
                            //       title: department.departmentNameWithCount,
                            //     );
                            //   },
                            // ),
                            child: ListView.builder(
                              itemCount: _searchTextController.text.isNotEmpty
                                  ? _searchResults.length
                                  : state.departments.length,
                              itemBuilder: (context, index) {
                                var department =
                                    _searchTextController.text.isNotEmpty
                                        ? _searchResults[index]
                                        : state.departments[index];
                                var isSelected =
                                    _selectedDepartments.contains(department);
                                final item = items[index % items.length];
                                return ListTile(
                                  selected: isSelected,
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedDepartments.remove(department);
                                      } else {
                                        _selectedDepartments.add(department);
                                      }
                                    });
                                  },
                                  leading: Image.asset(
                                    items[index]['image']!,
                                    height: 50,
                                    width: 50,
                                  ),
                                  title:
                                      Text(department.departmentNameWithCount),

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
                          );
                        }
                        if (state is EmptyList) {
                          return const EmptyState(
                              text: 'No Departments', icon: null);
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
            bottom: 10,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedDepartments);
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
        ],
      ),
    );
  }

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allDepartments.where(
        (value) {
          return (value.departmentName
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              value.departmentName.toLowerCase().contains(text.toLowerCase()));
        },
      ).toList();
    });
  }
}
