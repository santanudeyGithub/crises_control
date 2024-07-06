// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:ui';

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/list_models/users.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;
part 'user_list_page.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SelectedUser extends Equatable {
  const SelectedUser(this.userId, this.fullName);
  final int userId;
  final String fullName;

  @override
  List<Object?> get props => [userId, fullName];

  factory SelectedUser.fromJson(Map<String, dynamic> json) =>
      _$SelectedUserFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedUserToJson(this);
}

class UserListPage extends StatefulWidget {
  const UserListPage({
    super.key,
    required this.isIncidentManagerList,
    required this.selectedUsersId,
  });
  final List<SelectedUser> selectedUsersId;
  final bool isIncidentManagerList;

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final List<SelectedUser> _selectedUsers = [];
  List<UserData> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  final CCLoadingOverlay _ccLoadingOverlay = CCLoadingOverlay();
  List<UserData> _allUsers = [];

  bool _isChecked = false;
  bool _isDisabled = false;

  void _onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
      if (_isChecked) {
        _isDisabled = true;
      }
    });
  }

  //new model 13-06-2024 list view and others
  bool isMale = true;
  bool isIncidentScreen = true;
  bool isSignupScreen = false;
  bool isRememberMe = false;
  bool selectAll = false;

  void _toggleSelectAll() {
    setState(() {
      selectAll = !selectAll;
      for (var item in items) {
        item['checked'] = selectAll;
      }
    });
  }

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/aa_name.png',
      'text': 'Abrahama Atsbaha',
      'checked': false
    },
    {
      'image': 'assets/images/as_name.png',
      'text': 'Alma Salipot',
      'checked': false
    },
    {
      'image': 'assets/images/ah_name.png',
      'text': 'Asif Hussain',
      'checked': false
    },
    {
      'image': 'assets/images/gm_name.png',
      'text': 'Gerherd van der Merwe',
      'checked': false
    },
    {
      'image': 'assets/images/jp_name.png',
      'text': 'Juan-Pierre Roussow',
      'checked': false
    },
    {
      'image': 'assets/images/dw_name.png',
      'text': 'Dominic Warner',
      'checked': false
    },
    {
      'image': 'assets/images/jp_name.png',
      'text': 'Paul Davies',
      'checked': false
    },
    {
      'image': 'assets/images/jp_name.png',
      'text': 'Meandra van der Merwe',
      'checked': false
    },
    {
      'image': 'assets/images/jp_name.png',
      'text': 'Rickie Sehgal',
      'checked': false
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<ListCubit>().loadUsers();
    _selectedUsers.addAll(widget.selectedUsersId);
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.isIncidentManagerList
      //         ? language!.label_key_contacts
      //         : language!.label_users_to_notify,
      //   ),
      // ),
      body: Stack(
        children: [
          // searchBar.SearchBar(
          //   searchTextController: _searchTextController,
          //   onClear: (() {
          //     setState(() {
          //       _searchTextController.clear();
          //     });
          //   }),
          //   onChanged: (value) {
          //     setState(() {
          //       _onSearchTextChanged(value);
          //     });
          //   },
          // ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.label_users_to_notify,
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
                  )),
            ),
          ),
          // WillPopScope(
          //   onWillPop: () async {
          //     Navigator.pop(context, _selectedUsers);
          //     return true;
          //   },
          //   child: BlocConsumer<ListCubit, ListState>(
          //     listener: (context, state) {
          //       handleStateChanges(state, context);
          //     },
          //     builder: (context, state) {
          //       if (state is UsersListsLoaded) {
          //         return Expanded(
          //           child: ListView.builder(
          //             itemCount: _searchTextController.text.isNotEmpty
          //                 ? _searchResults.length
          //                 : state.users.length,
          //             itemBuilder: ((context, index) {
          //               var user = _searchTextController.text.isNotEmpty
          //                   ? _searchResults[index]
          //                   : state.users[index];
          //               var isSelected = _selectedUsers
          //                   .contains(SelectedUser(user.userId, user.fullName));
          //               return SelectionListTile(
          //                 isSelected: isSelected,
          //                 onTap: () {
          //                   if (isSelected) {
          //                     setState(() {
          //                       _selectedUsers.removeWhere(
          //                           (element) => element.userId == user.userId);
          //                     });
          //                   } else {
          //                     setState(() {
          //                       _selectedUsers.add(
          //                           SelectedUser(user.userId, user.fullName));
          //                     });
          //                   }
          //                 },
          //                 title: user.fullName,
          //               );
          //             }),
          //           ),
          //         );
          //       }
          //       if (state is EmptyList) {
          //         return const EmptyState(
          //           text: 'No Users',
          //           icon: null,
          //         );
          //       }
          //       return Container();
          //     },
          //   ),
          // ),
          Positioned(
            top: 145, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 115,

            child: Expanded(
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0), // Top left corner
                    topRight: Radius.circular(20.0), // Top right corner
                    bottomLeft: Radius.circular(20.0), // Bottom left corner
                    bottomRight: Radius.circular(20.0), // Bottom right corner
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index % items.length];
                      return ListTile(
                        leading: Image.asset(
                          items[index]['image']!,
                          height: 45,
                          width: 45,
                        ),
                        title: Text(
                          item['text'],
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        // trailing: SvgPicture.asset(
                        // 'assets/images/img_checkmark_blue_gray_100.svg'),
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
                  ),
                ),
              ),
            ),
          ),
          // Opacity(
          //   opacity: 0.5,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 58, left: 250),
          //     child: Container(
          //       child: Row(
          //         children: [
          //           Column(
          //             children: [
          //               TextButton(
          //                 onPressed: _toggleSelectAll,
          //                 child: Text(
          //                   selectAll ? 'Deselect All' : 'Select All',
          //                   style: GoogleFonts.urbanist(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w600,
          //                     color: const Color(0xff0B223C),
          //                     height: 19.2,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Center(
            child: GestureDetector(
              onTap: () {
                print('Custom flat button pressed');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 755),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xff1E60AA),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'done'.toUpperCase(),
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      // height: 19.2
                    ),
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
    if (state is UsersListsLoaded) _allUsers = state.users;
    if (state is ListLoading) {
      _ccLoadingOverlay.show(context);
    } else {
      _ccLoadingOverlay.hide();
    }
    if (state is ListError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
  }

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allUsers.where(
        (value) {
          return (value.fullName.toLowerCase().contains(text.toLowerCase()) ||
              value.fullName.toLowerCase().contains(text.toLowerCase()));
        },
      ).toList();
    });
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            //color: value ? Colors.blue : Colors.grey,
            color: Color(0xff1E60AA),
            width: 2.0,
          ),
          //color: value ? Colors.blue : Colors.transparent,
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 20.0,
                color: Color(0xff1E60AA),
              )
            : null,
      ),
    );
  }
}
