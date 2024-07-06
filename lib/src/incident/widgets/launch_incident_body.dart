// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors, use_super_parameters, unused_element

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/presentation/widgets/menu_widgets.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/core/utils/converters/icon_converters.dart';
import 'package:crises_control/src/core/utils/string_extension.dart';
import 'package:crises_control/src/incident/cubits/launch_incident/launch_incident_cubit.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:crises_control/src/login/view/widgets/custom_image_view.dart';
import 'package:crises_control/src/login/view/widgets/image_constant.dart';
import 'package:crises_control/src/ping/widgets/new_ping_body.dart';
import 'package:crises_control/src/theme/app_decoration.dart';
import 'package:crises_control/src/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchIncidentBody extends StatefulWidget {
  const LaunchIncidentBody(
      {super.key,
      required this.incidentId,
      required this.launchIncidentDetailsLoaded});
  final LaunchIncidentDetailsLoaded launchIncidentDetailsLoaded;
  final int incidentId;

  @override
  State<LaunchIncidentBody> createState() => _LaunchIncidentBody();
}

class _LaunchIncidentBody extends State<LaunchIncidentBody> {
  String _message = '';
  List<LocationsData> _selectedLocations = [];
  List<AffectedLocationsData> _selectedAffectedLocations = [];
  List<GroupData> _selectedGroups = [];
  List<SelectedUser> _selectedUsers = [];
  List<SelectedUser> _selectedIncidentManagers = [];
  List<DepartmentsData> _selectedDepartments = [];
  List<SelectedCommunication> _selectedCommunicationPreferences = [];
  List<SelectedCommunication> _severityCommChannels1 = [];
  List<SelectedCommunication> _severityCommChannels2 = [];
  List<SelectedCommunication> _severityCommChannels3 = [];
  List<SelectedCommunication> _severityCommChannels4 = [];
  List<SelectedCommunication> _severityCommChannels5 = [];
  List<MessageMethod> _allCommunicationChannels = [];
  List<CascadingPlan> _allCascadingPlans = [];
  List<AcknowledgeOption> _selectedAcknowledgeOptions = [];
  List<LocationsData> _selectedImpactedLocations = [];
  List<String> _selectedSocialIntergrations = [];
  final CCLoadingOverlay _ccLoadingOverlay = CCLoadingOverlay();
  int selectedIndex = -1;

  // final List<Map<String, dynamic>> options = [
  //   {
  //     'label': 'Minor',
  //     'icon': Icons.info,
  //     'iconColor': Colors.green,
  //     'textColor': Colors.green
  //   },
  //   {
  //     'label': 'Major',
  //     'icon': Icons.warning,
  //     'iconColor': Colors.orange,
  //     'textColor': Color.fromARGB(255, 253, 165, 34),
  //   },
  //   {
  //     'label': 'Critical',
  //     'icon': Icons.error,
  //     'iconColor': Colors.red,
  //     'textColor': Color.fromARGB(255, 236, 7, 49)
  //   },
  // ];

  bool _isChecked1 = true;
  bool _isChecked2 = true;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  int? _severity = 1;
  @override
  void initState() {
    super.initState();
    _severity = widget.launchIncidentDetailsLoaded.incidentDetailData.severity;
    _message =
        widget.launchIncidentDetailsLoaded.incidentDetailData.description;

    //Comms
    bool allowChannelSeveritySetup =
        RepositoryProvider.of<CrisesControlCoreRepository>(context)
            .getCompanyParamValue(CompanyParamKeys.allowChannelSeveritySetup)
            .toBool();
    if (allowChannelSeveritySetup) {
      var defaultCommunicationPreferences = widget
          .launchIncidentDetailsLoaded.incidentDetailData.messageMethods
          .map((mm) => mm.toSelectedCommunication())
          .toList();
      List<SelectedCommunication> defaultSeverityCommunicationPreferences;
      switch (_severity) {
        case 1:
          defaultSeverityCommunicationPreferences = _severityCommChannels1;
          break;
        case 2:
          defaultSeverityCommunicationPreferences = _severityCommChannels2;
          break;
        case 3:
          defaultSeverityCommunicationPreferences = _severityCommChannels3;
          break;
        case 4:
          defaultSeverityCommunicationPreferences = _severityCommChannels4;
          break;
        case 5:
          defaultSeverityCommunicationPreferences = _severityCommChannels5;
          break;
        default:
          defaultSeverityCommunicationPreferences = _severityCommChannels1;
      }
      _selectedCommunicationPreferences =
          defaultSeverityCommunicationPreferences.isNotEmpty
              ? defaultSeverityCommunicationPreferences
              : defaultCommunicationPreferences;
    }

    _selectedCommunicationPreferences = widget
        .launchIncidentDetailsLoaded.incidentDetailData.messageMethods
        .map((mm) => mm.toSelectedCommunication())
        .toList();
    _severityCommChannels1 =
        widget.launchIncidentDetailsLoaded.severityCommChannels1;
    _severityCommChannels2 =
        widget.launchIncidentDetailsLoaded.severityCommChannels2;
    _severityCommChannels3 =
        widget.launchIncidentDetailsLoaded.severityCommChannels3;
    _severityCommChannels4 =
        widget.launchIncidentDetailsLoaded.severityCommChannels4;
    _severityCommChannels5 =
        widget.launchIncidentDetailsLoaded.severityCommChannels5;
    _allCommunicationChannels =
        widget.launchIncidentDetailsLoaded.allCommunicationChannels;
    _allCascadingPlans =
        widget.launchIncidentDetailsLoaded.allCascadingChannels;

    _selectedIncidentManagers = ListHelpers.incKeyContactsListToSelectedUser(
        widget.launchIncidentDetailsLoaded.incidentDetailData.incKeyCon);
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    var coreRepository =
        RepositoryProvider.of<CrisesControlCoreRepository>(context);

    return BlocConsumer<LaunchIncidentCubit, LaunchIncidentState>(
      listener: (context, state) {
        _handleStateChanges(state, context);
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 30,
                    left: 0,
                    right: 0), // Adjust this to position the box
                padding: EdgeInsets.all(16.0),
                width: 365,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 25), // Space for the circle
                    Text(
                      'Backup failure',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          color: Color(0xff0B223C),
                          fontWeight: FontWeight.w600),
                    ),

                    SizedBox(height: 20),
                    // Container(
                    //   height: 115,
                    //   width: 400,
                    //   decoration: BoxDecoration(
                    //     color: const Color.fromARGB(255, 235, 234, 234),
                    //     borderRadius: BorderRadius.circular(12.0),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 2,
                    //         blurRadius: 7,
                    //         offset: Offset(0, 3), // changes position of shadow
                    //       ),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 200, top: 15),
                    //         child: Container(
                    //           child: Text(
                    //             "Message",
                    //             style: TextStyle(),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         child: Opacity(
                    //           opacity: 0.6,
                    //           child: Container(
                    //             width: 266,
                    //             margin: EdgeInsets.only(right: 2, top: 10),
                    //             child: Text(
                    //               "In publishing and graphic design, Lorem \nipsum is a placeholder text commonly used \nto demonstrate the visual form…",
                    //               maxLines: 3,
                    //               overflow: TextOverflow.ellipsis,
                    //               style: TextStyle(),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 150,
                child: Container(
                  width: 80, // Adjust size
                  height: 80, // Adjust size
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255), // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  child: CircleAvatar(
                      radius:
                          55, // Half the width/height minus the border width
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Image(
                          image: AssetImage('assets/images/L_I_Logo.png'))),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 170,
                        left: 0,
                        right: 0), // Adjust this to position the box
                    padding: EdgeInsets.only(bottom: 0, top: 0),
                    width: 365,
                    height: 148, // Specify the height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // _LaunchIncidentHeader(
                        //     incident: widget.launchIncidentDetailsLoaded
                        //         .incidentDetailData),
                        Container(
                          child: MenuRow(
                            icon: Icons.chat,
                            title: language!.label_message,
                            imagePath: 'assets/images/Messages_icon_new.png',
                            type: MenuRowType.message,
                            onPressed: () => _onMessage(
                              incidentMessages: widget
                                  .launchIncidentDetailsLoaded
                                  .incidentDetailData
                                  .actionLst,
                            ),
                            subtitle: _message,
                            messageType: BackendConstants.messageTypeIncident,
                          ),
                        ),
                        Container(
                          child: MenuRow(
                            icon: Icons.supervised_user_circle,
                            title: language.label_key_contacts,
                            imagePath: 'assets/images/Incident_Managers.png',
                            type: MenuRowType.incidentManagers,
                            onPressed: _onIncidentManager,
                            subtitle: ListHelpers.selectedUserListToString(
                              _selectedIncidentManagers,
                            ),
                            messageType: BackendConstants.messageTypeIncident,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 25,
                        left: 0,
                        right: 0), // Adjust this to position the box
                    padding: EdgeInsets.all(2.0),
                    width: 365,
                    height: 360, // Specify the height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        MenuRow(
                          icon: Icons.place,
                          title: language.label_locations_to_notify,
                          imagePath: 'assets/images/location_border.png',
                          type: MenuRowType.locations,
                          onPressed: _onLocationsToNotify,
                          subtitle: ListHelpers.locationListToString(
                              _selectedLocations),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                        MenuRow(
                          icon: Icons.groups,
                          title: language.label_groups_to_notify,
                          imagePath: 'assets/images/gro_noty.png',
                          type: MenuRowType.groups,
                          onPressed: _onGroupsToNotify,
                          subtitle:
                              ListHelpers.groupListToString(_selectedGroups),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                        MenuRow(
                          icon: Icons.reduce_capacity,
                          title: language.label_departments_to_notify,
                          imagePath: 'assets/images/depart_noty.png',
                          type: MenuRowType.departments,
                          onPressed: _onDepartmentsToNotify,
                          subtitle: ListHelpers.departmentListToString(
                              _selectedDepartments),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                        MenuRow(
                          icon: Icons.person,
                          title: language.label_users_to_notify,
                          imagePath: 'assets/images/usr_notif.png',
                          type: MenuRowType.users,
                          onPressed: _onUsersToNotify,
                          subtitle: ListHelpers.selectedUserListToString(
                              _selectedUsers),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                        MenuRow(
                          icon: Icons.pin_drop,
                          title: language.label_impacted_location,
                          imagePath: 'assets/images/impact_location.png',
                          type: MenuRowType.impactedLocation,
                          onPressed: _onImpactedLocationsToNotify,
                          subtitle: ListHelpers.locationListToString(
                            _selectedImpactedLocations,
                          ),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                      ],
                    ),

                    // child: Column(
                    // children: [
                    //  Text(language.label_severity_level),
                    // const SizedBox(height: 8),
                    // Wrap(
                    //   children: List<Widget>.generate(
                    // 3,
                    // (int index) {
                    //   var severity = index + 1;
                    //  return Padding(
                    //   padding:
                    //     const EdgeInsets.symmetric(horizontal: 2),
                    //  child: ChoiceChip(
                    //   label: Text(severity.toString()),
                    //  selected: _severity == index + 1,
                    // onSelected: (bool selected) {
                    //   setState(() {
                    //    _severity = selected ? index + 1 : null;
                    //   bool allowChannelSeveritySetup =
                    //     coreRepository
                    //   .getCompanyParamValue(
                    //  CompanyParamKeys
                    //    .allowChannelSeveritySetup)
                    // .toBool();
                    // if (allowChannelSeveritySetup) {
                    ////  switch (_severity) {
                    //  case 1:
                    // _selectedCommunicationPreferences =
                    //     _severityCommChannels1;
                    //  break;
                    //  case 2:
                    //  _selectedCommunicationPreferences =
                    //  _severityCommChannels2;
                    //  break;
                    // case 3:
                    //  _selectedCommunicationPreferences =
                    //       _severityCommChannels3;
                    //   break;
                    //  case 4:
                    //  _selectedCommunicationPreferences =
                    //     _severityCommChannels4;
                    // break;
                    // case 5:
                    //  _selectedCommunicationPreferences =
                    //      _severityCommChannels5;
                    // break;
                    // default:
                    // }
                    // }
                    //  });
                    // },
                    // ),
                    // );
                    // },
                    //  ).toList()),
                    // ],
                    // ),

                    //New Page design severity - 05-06-2024

                    // child: Center(
                    //   child: Stack(
                    //     alignment: Alignment.center,
                    //     children: [
                    //       DecorativeBox(), // Decorative container
                    //       Positioned(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: List.generate(options.length, (index) {
                    //             return GestureDetector(
                    //               onTap: () {
                    //                 setState(() {
                    //                   selectedIndex = index;
                    //                 });
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(top: 25),
                    //                 child: Container(
                    //                   width: 100,
                    //                   height: 80,
                    //                   decoration: BoxDecoration(
                    //                     color:
                    //                         Color.fromARGB(255, 238, 237, 237),
                    //                     borderRadius: BorderRadius.circular(15),
                    //                     border: Border.all(
                    //                       color: Colors.white,
                    //                       width: 2,
                    //                     ),
                    //                     // boxShadow: [
                    //                     //   BoxShadow(
                    //                     //     color: Colors.grey.withOpacity(0.5),
                    //                     //     spreadRadius: 1,
                    //                     //     blurRadius: 3,
                    //                     //     offset: Offset(0,
                    //                     //         3), // changes position of shadow
                    //                     //   ),
                    //                     // ],
                    //                   ),
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: [
                    //                       Icon(
                    //                         options[index]['icon'],
                    //                         color: selectedIndex == index
                    //                             ? options[index]['iconColor']
                    //                             : Colors
                    //                                 .grey, // Change icon color
                    //                       ),
                    //                       SizedBox(height: 8),
                    //                       Text(
                    //                         options[index]['label'],
                    //                         style: TextStyle(
                    //                           color: selectedIndex == index
                    //                               ? options[index]['textColor']
                    //                               : Colors
                    //                                   .black, // Change text color
                    //                           fontSize: 18,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           }),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                        top: 25,
                        left: 0,
                        right: 0), // Adjust this to position the box
                    padding: EdgeInsets.all(2.0),
                    width: 365,
                    height: 125, // Specify the height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        MenuRow(
                          icon: Icons.podcasts,
                          title: language.myaccount_comm_prefs,
                          imagePath: 'assets/images/commi_pref.png',
                          type: MenuRowType.communicationPreferences,
                          onPressed: () {}, //_onCommunicationPreferences,
                          subtitle:
                              ListHelpers.selectedMessageMethodListToString(
                                  _selectedCommunicationPreferences),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Text',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3A3A3A)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isChecked1 = !_isChecked1;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xff1760AB)
                                            .withOpacity(0.5), // Border color
                                        width: 2.0, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          4.0), // Border radius
                                    ),
                                    child: _isChecked1
                                        ? Icon(
                                            Icons.check,
                                            size: 18.0,
                                            color: Colors.blue, // Check color
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Phone',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3A3A3A)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isChecked4 = !_isChecked4;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffDDE6EC)
                                            .withOpacity(0.5), // Border color
                                        width: 2.0, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          4.0), // Border radius
                                    ),
                                    child: _isChecked4
                                        ? Icon(Icons.check,
                                            size: 18.0,
                                            color:
                                                Color(0xff1760AB) // Check color
                                            )
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Email',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3A3A3A)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isChecked3 = !_isChecked3;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffDDE6EC)
                                            .withOpacity(0.5), // Border color
                                        width: 2.0, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          4.0), // Border radius
                                    ),
                                    child: _isChecked3
                                        ? Icon(Icons.check,
                                            size: 18.0,
                                            color:
                                                Color(0xff1760AB) // Check color
                                            )
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Push',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3A3A3A)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isChecked2 = !_isChecked2;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xff1760AB)
                                            .withOpacity(0.5), // Border color
                                        width: 2.0, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          4.0), // Border radius
                                    ),
                                    child: _isChecked2
                                        ? Icon(Icons.check,
                                            size: 18.0,
                                            color:
                                                Color(0xff1760AB) // Check color
                                            )
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 25,
                        left: 0,
                        right: 0), // Adjust this to position the box
                    padding: EdgeInsets.all(2.0),
                    width: 365,
                    height: 80, // Specify the height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        MenuRow(
                          icon: Icons.podcasts,
                          title: language.myaccount_comm_prefs,
                          imagePath: 'assets/images/Channel_Cascading_Plan.png',
                          type: MenuRowType.communicationPreferences,
                          onPressed: () {}, //_onCommunicationPreferences,
                          subtitle:
                              ListHelpers.selectedMessageMethodListToString(
                                  _selectedCommunicationPreferences),
                          messageType: BackendConstants.messageTypeIncident,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 0,
                        left: 0,
                        right: 0), // Adjust this to position the box
                    padding: EdgeInsets.all(2.0),
                    width: 365,
                    height: 200, // Specify the height here

                    child: Container(
                      // child: Column(
                      // children: [
                      //  Text(language.label_severity_level),
                      // const SizedBox(height: 8),
                      // Wrap(
                      //   children: List<Widget>.generate(
                      // 3,
                      // (int index) {
                      //   var severity = index + 1;
                      //  return Padding(
                      //   padding:
                      //     const EdgeInsets.symmetric(horizontal: 2),
                      //  child: ChoiceChip(
                      //   label: Text(severity.toString()),
                      //  selected: _severity == index + 1,
                      // onSelected: (bool selected) {
                      //   setState(() {
                      //    _severity = selected ? index + 1 : null;
                      //   bool allowChannelSeveritySetup =
                      //     coreRepository
                      //   .getCompanyParamValue(
                      //  CompanyParamKeys
                      //    .allowChannelSeveritySetup)
                      // .toBool();
                      // if (allowChannelSeveritySetup) {
                      ////  switch (_severity) {
                      //  case 1:
                      // _selectedCommunicationPreferences =
                      //     _severityCommChannels1;
                      //  break;
                      //  case 2:
                      //  _selectedCommunicationPreferences =
                      //  _severityCommChannels2;
                      //  break;
                      // case 3:
                      //  _selectedCommunicationPreferences =
                      //       _severityCommChannels3;
                      //   break;
                      //  case 4:
                      //  _selectedCommunicationPreferences =
                      //     _severityCommChannels4;
                      // break;
                      // case 5:
                      //  _selectedCommunicationPreferences =
                      //      _severityCommChannels5;
                      // break;
                      // default:
                      // }
                      // }
                      //  });
                      // },
                      // ),
                      // );
                      // },
                      //  ).toList()),
                      // ],
                      // ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SeveritySlider(), // Decorative container
                            // Positioned(
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children:
                            //         List.generate(options.length, (index) {
                            //       return GestureDetector(
                            //         onTap: () {
                            //           setState(() {
                            //             selectedIndex = index;
                            //           });
                            //         },
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(top: 0),
                            //           child: Container(
                            //             width: 80,
                            //             height: 80,
                            //             decoration: BoxDecoration(
                            //               color: Color.fromARGB(
                            //                   255, 238, 237, 237),
                            //               borderRadius:
                            //                   BorderRadius.circular(15),
                            //               border: Border.all(
                            //                 color: Colors.white,
                            //                 width: 2,
                            //               ),
                            //             ),
                            //             child: Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: [
                            //                 Icon(
                            //                   options[index]['icon'],
                            //                   color: selectedIndex == index
                            //                       ? options[index]['iconColor']
                            //                       : Colors
                            //                           .grey, // Change icon color
                            //                 ),
                            //                 SizedBox(height: 8),
                            //                 Text(
                            //                   options[index]['label'],
                            //                   style: TextStyle(
                            //                     color: selectedIndex == index
                            //                         ? options[index]
                            //                             ['textColor']
                            //                         : Colors
                            //                             .black, // Change text color
                            //                     fontSize: 18,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //_SimulateButton(language: language),

                  Container(
                    margin: EdgeInsets.only(
                        top: 15,
                        left: 0,
                        right: 0), // Adjust this to position the box
                    padding: EdgeInsets.all(2.0),
                    width: 365,
                    height: 150, // Specify the height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AdvanceOptionsMenuRow(
                            icon: Icons.settings,
                            imagePath: 'assets/images/advaceoptions.png',
                            isPing: false,
                            onPressed: () {},
                            acknowledgeOptions: widget
                                .launchIncidentDetailsLoaded
                                .incidentDetailData
                                .ackOptions
                                .map((val) => (val.responseLabel))
                                .toList(),
                            onAffectedLocationsPressed:
                                _onAffectedLocationsToNotify,
                          ),
                          // Visibility(
                          //   //TODO Social Posting
                          //   visible: coreRepository
                          //       .getCompanyParamValue(
                          //           CompanyParamKeys.allowSocialPosting)
                          //       .toBool(),
                          //   child: const Divider(),
                          // ),
                          // Visibility(
                          //   visible: coreRepository
                          //       .getCompanyParamValue(
                          //           CompanyParamKeys.allowSocialPosting)
                          //       .toBool(),
                          //   child: AdvancedOptionTile(
                          //     title: language.label_social_post,
                          //     onTapped: _onSocialIntergrations,
                          //     icon: Icons.post_add,
                          //     imagePath: 'assets/images/SocialPost.png',
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 0, bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffDDE6EC), // Text color
                            elevation: 5, // Elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Button border radius
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 53, vertical: 16),
                          ),
                          child: Text(
                            'Simulate'.toUpperCase(),
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                      ),
                      SizedBox(width: 2), // Add some space between the buttons
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 0, bottom: 10),
                        child: ElevatedButton(
                          // onPressed: () {
                          //   // _showPopup(context);

                          // },
                          onPressed: () {
                            _showBeautifulSnackbar(context);
                          },

                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffDDE6EC), // Text color
                            elevation: 5, // Elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Button border radius
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 16),
                          ),
                          child: Text(
                            'Launch'.toUpperCase(),
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
              SizedBox(height: 35),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTwenty(
    BuildContext context, {
    required String videoCamera,
    required String major,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 1),
          CustomImageView(
            imagePath: videoCamera,
            height: 35,
            width: 35,
          ),
          SizedBox(height: 2),
          Text(
            major,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  void _handleStateChanges(LaunchIncidentState state, BuildContext context) {
    if (state is LaunchIncidentLoading) {
      _ccLoadingOverlay.show(context);
    } else {
      _ccLoadingOverlay.hide();
    }

    if (state is LaunchIncidentErrorPop) {
      showDialog(
        context: context,
        builder: (context) => state.error.displayErrorAlerts(context),
      );
      Navigator.pop(context);
    }
    if (state is LaunchIncidentError) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }

    if (state is LaunchIncidentLaunched) {
      showDialog(
        context: context,
        builder: (context) => CCAlertDialog(
          title: "Success",
          description: "Incident launched successfully",
          actions: const [
            OkAlertButton(),
          ],
        ),
      );
    }
  }

  //Navigation methods
  _onMessage({required List<IncidentMessages> incidentMessages}) async {
    final message = await Navigator.pushNamed(
      context,
      RouteConstants.messageEditorPage,
      arguments: MessageEditorPageArguments(
        _message,
        incidentMessages,
      ),
    ) as String;
    setState(
      () {
        _message = message;
      },
    );
  }

  _onUsersToNotify() async {
    final users = await Navigator.pushNamed(
      context,
      RouteConstants.userListPage,
      arguments: UserListPageArguments(false, []),
    ) as List<SelectedUser>;
    setState(
      () {
        _selectedUsers = users;
      },
    );
  }

  _onIncidentManager() async {
    final incidentManagers = await Navigator.pushNamed(
      context,
      RouteConstants.userListPage,
      arguments: UserListPageArguments(false, _selectedIncidentManagers),
    ) as List<SelectedUser>;
    setState(
      () {
        _selectedIncidentManagers = incidentManagers;
      },
    );
  }

  _onGroupsToNotify() async {
    final groups = await Navigator.pushNamed(
      context,
      RouteConstants.groupListPage,
      arguments: GroupListPageArguments(_selectedGroups),
    ) as List<GroupData>;
    setState(
      () {
        _selectedGroups = groups;
      },
    );
  }

  _onDepartmentsToNotify() async {
    final departments = await Navigator.pushNamed(
      context,
      RouteConstants.departmentListPage,
      arguments: DepartmentListPageArguments(_selectedDepartments),
    ) as List<DepartmentsData>;
    setState(
      () {
        _selectedDepartments = departments;
      },
    );
  }

  _onLocationsToNotify() async {
    final locations =
        await Navigator.pushNamed(context, RouteConstants.locationsListPage,
            arguments: LocationListPageArguments(
              _selectedLocations,
              LocationListType.toNotify,
            )) as List<LocationsData>;
    setState(() {
      _selectedLocations = locations;
    });
  }

  _onImpactedLocationsToNotify() async {
    final locations =
        await Navigator.pushNamed(context, RouteConstants.locationsListPage,
            arguments: LocationListPageArguments(
              _selectedLocations,
              LocationListType.impacted,
            )) as List<LocationsData>;
    setState(() {
      _selectedLocations = locations;
    });
  }

  _onAffectedLocationsToNotify() async {
    final affectedLocations = await Navigator.pushNamed(
        context, RouteConstants.affectedLocationsListPage,
        arguments: AffectedLocationListPageArguments(
          _selectedAffectedLocations,
        )) as List<AffectedLocationsData>;
    setState(() {
      _selectedAffectedLocations = affectedLocations;
    });
  }

  _onCommunicationPreferences() async {
    final communicationPrefences = await Navigator.pushNamed(
        context, RouteConstants.communicationPrefencesListPage,
        arguments: CommunicationPrefencesListPageArguments(
          _allCommunicationChannels,
          _selectedCommunicationPreferences,
          _allCascadingPlans,
        )) as List<SelectedCommunication>;
    setState(() {
      _selectedCommunicationPreferences = communicationPrefences;
    });
  }

  _onSocialIntergrations() async {
    final socialIntergrations = await Navigator.pushNamed(
      context,
      RouteConstants.SocialIntergrationsListPage,
      arguments: SocialIntergrationsListPageArguments(
        _selectedSocialIntergrations,
      ),
    ) as List<String>?;
    if (socialIntergrations != null) {
      setState(
        () {
          _selectedSocialIntergrations = socialIntergrations;
        },
      );
    }
  }

  // void _showPopup(BuildContext context) {
  //   var language = AppLocalizations.of(context);
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Successfully Launched'),
  //         content:
  //             Text(language!.e116, //Text('Incident has launched successfully',
  //                 style: GoogleFonts.urbanist(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                 )),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               // Close the popup when the button is pressed
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               'OK',
  //               style: GoogleFonts.urbanist(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                   color: Color(0xff1E60AA)),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _showBeautifulSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          // Icon(
          //   Icons.check_circle,
          //   color: Color(0xff28A745),
          // ),
          Image(
            image: AssetImage('assets/images/Acknowledgedsuccessfully.png'),
            color: Color(0xff28A745),
            height: 30,
            width: 30,
          ),
          SizedBox(width: 10),
          Expanded(
              child: Text(
            'Acknowledged successfully',
            style: GoogleFonts.roboto(
              color: Color(0xff28A745),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          )),
        ],
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction(
      //   label: 'Dismiss',
      //   textColor: Color(0xff28A745),
      //   onPressed: () {
      //     // Some action to dismiss.
      //   },
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.all(16),
      duration: Duration(seconds: 10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class SeveritySlider extends StatefulWidget {
  @override
  State<SeveritySlider> createState() => _SeveritySliderState();
}

class _SeveritySliderState extends State<SeveritySlider> {
  double _currentSliderValue = 1;
  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 201, 199, 199).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 1),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/SeverityLevel.png'),
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(width: 8), // Adjust spacing between icon and text
                  Text(language!.label_severity_level),
                ],
              ),
            ),
            // SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text('Low'),
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue.round().toString(),
                      activeColor: Colors.red,
                      inactiveColor: Color(0xffF2F2F2),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                  Text('High'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  int number = index + 1;
                  return Text(
                    '$number',
                    style: TextStyle(
                      color: number == _currentSliderValue.round()
                          ? Colors.red
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimulateButton extends StatelessWidget {
  const _SimulateButton({
    Key? key,
    required this.language,
  }) : super(key: key);

  final AppLocalizations language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: Text(
            language.btn_incident_simulate,
          )),
    );
  }
}

class _LaunchButton extends StatelessWidget {
  const _LaunchButton({
    Key? key,
    required this.language,
    required this.incidentId,
    required this.message,
    required this.locationsToNotify,
    required this.groups,
    required this.departments,
    required this.usersToNotify,
    required this.keyContacts,
    required this.impactedLocations,
    required this.selectedCommunicationMethods,
    required this.affectedLocations,
    required this.ackOptions,
    required this.isSlientMessage,
    required this.trackUser,
    required this.severity,
    required this.cascadingPlanId,
    required this.isSimulation,
  }) : super(key: key);

  final AppLocalizations language;
  final int incidentId;
  final String message;
  final List<LocationsData> locationsToNotify;
  final List<GroupData> groups;
  final List<DepartmentsData> departments;
  final List<SelectedUser> usersToNotify;
  final List<SelectedUser> keyContacts;
  final List<LocationsData> impactedLocations;
  final List<SelectedCommunication> selectedCommunicationMethods;
  final List<LocationsData> affectedLocations;
  final List<AcknowledgeOption> ackOptions;
  final bool isSlientMessage;
  final bool trackUser;
  final int severity;
  final int cascadingPlanId;
  final bool isSimulation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary,
          ),
          child: Text(
            language.btn_label_incident_launch,
          )),
    );
  }
}

class _LaunchIncidentHeader extends StatelessWidget {
  const _LaunchIncidentHeader({
    Key? key,
    required this.incident,
  }) : super(key: key);

  final IncidentDetailData incident;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Image.network(
          //   incident.incidentIcon,
          //   loadingBuilder: (context, child, loadingProgress) {
          //     return Image.asset(
          //       'assets/images/logo_high_res.png',
          //       width: 60,
          //       height: 60,
          //     );
          //   },
          //   errorBuilder: (context, error, stackTrace) {
          //     return Image.asset(
          //       'assets/images/logo_high_res.png',
          //       width: 60,
          //       height: 60,
          //     );
          //   },
          // ),
          const SizedBox(width: 15),
          Flexible(
            child: Text(
              incident.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
