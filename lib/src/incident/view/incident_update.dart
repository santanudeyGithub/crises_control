import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:crises_control/src/incident/widgets/impact_location.dart';
import 'package:crises_control/src/incident/widgets/widgets.dart';
import 'package:crises_control/src/login/view/widgets/custom_image_view.dart';
import 'package:crises_control/src/login/view/widgets/image_constant.dart';
import 'package:crises_control/src/theme/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateIncident extends StatefulWidget {
  const UpdateIncident({super.key});

  @override
  State<UpdateIncident> createState() => _UpdateIncidentState();
}

class _UpdateIncidentState extends State<UpdateIncident> {
  List<GroupData> _selectedGroups = [];
  // Dropdown options
  String? selectedValue;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: "Social",
        child: ListTile(
          leading: Icon(
            Icons.post_add,
            color: Colors.blue,
          ),
          title: Text('Social Post'),
          //subtitle: Text('View map'),
        ),
      ),
    ];
    return menuItems;
  }

  int selectedIndex = -1;

  final List<Map<String, dynamic>> options = [
    {
      'label': 'Minor',
      'icon': Icons.info,
      'iconColor': Colors.green,
      'textColor': Colors.green
    },
    {
      'label': 'Major',
      'icon': Icons.warning,
      'iconColor': Colors.orange,
      'textColor': Color.fromARGB(255, 253, 165, 34),
    },
    {
      'label': 'Critical',
      'icon': Icons.error,
      'iconColor': Colors.red,
      'textColor': Color.fromARGB(255, 236, 7, 49)
    },
  ];

  @override
  Widget build(BuildContext context) {
    // var language = AppLocalizations.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(language!.title_incident_messages),
      //   actions: [_IncidentActions(language: language)],
      // ),
      // bottomNavigationBar: IncidentActionTabBar(language: language),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              //title: language!.title_incident_messages,
              title: 'Incident Update',
              actionIcon: GestureDetector(
                onTap: () async {
                  //showCustomDialog(context, 3);
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
          Positioned(
            top: 135, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 30,
                        left: 15,
                        right: 15), // Adjust this to position the box
                    padding: EdgeInsets.all(16.0),
                    width: 350,
                    height: 225,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
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
                          'Pandemic',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(fontSize: 22),
                        ),

                        SizedBox(height: 20),
                        Container(
                          height: 115,
                          width: 400,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 235, 234, 234),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 200, top: 15),
                                child: Container(
                                  child: Text(
                                    "Message",
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Container(
                                    width: 266,
                                    margin: EdgeInsets.only(right: 2, top: 10),
                                    child: Text(
                                      "In publishing and graphic design, Lorem \nipsum is a placeholder text commonly used \nto demonstrate the visual form…",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 156,
                    child: Container(
                      width: 70, // Adjust size
                      height: 70, // Adjust size
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.fromARGB(
                              255, 255, 255, 255), // Border color
                          width: 4.0, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                          radius:
                              55, // Half the width/height minus the border width
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          child: Image(
                              image: AssetImage(
                                  'assets/images/img_settings_primary.png'))),
                    ),
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 278,
                                left: 15,
                                right: 15), // Adjust this to position the box
                            padding: EdgeInsets.only(bottom: 45, top: 0),
                            width: 350,
                            height: 400, // Specify the height here
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListView(
                              children: [
                                ListTile(
                                  leading: Image(
                                    image: AssetImage(
                                        'assets/images/loca_noty.png'),
                                  ),
                                  title: Text('Location(s) to Notify'),
                                  //  subtitle: Text('View map'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    print('Map tapped');
                                    // Add your onTap functionality here
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImpactLocation()),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Image(
                                    image: AssetImage(
                                        'assets/images/gro_noty.png'),
                                  ),
                                  title: Text('Group(s) to Notify'),
                                  //  subtitle: Text('View album'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteConstants.groupListPage);
                                  },
                                ),
                                ListTile(
                                  leading: Image(
                                    image: AssetImage(
                                        'assets/images/depart_noty.png'),
                                  ),
                                  title: Text('Department(s) to Notify'),
                                  // subtitle: Text('View album'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    print('Album tapped');
                                    // Add your onTap functionality here
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ImpactLocation()),
                                    // );
                                    Navigator.pushNamed(
                                      context,
                                      RouteConstants.departmentListPage,
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Image(
                                    image: AssetImage(
                                        'assets/images/user_noty.png'),
                                  ),
                                  title: Text('Users to Notify'),
                                  // subtitle: Text('View album'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    print('Album tapped');
                                    // Add your onTap functionality here
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ImpactLocation()),
                                    // );
                                    Navigator.pushNamed(
                                        context, RouteConstants.userListPage);
                                  },
                                ),
                                DropdownButton<String>(
                                  value: selectedValue,
                                  items: dropdownItems,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  isExpanded:
                                      true, // This ensures the dropdown expands to the full width
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/adva_options.png'),
                                        ),
                                        SizedBox(width: 10),
                                        Text('Advanced Options',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image(
                                    image: AssetImage(
                                        'assets/images/commi_pref.png'),
                                  ),
                                  title: Text('Communication Preferences'),
                                  // subtitle: Text('View album'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    print('Album tapped');
                                    // Add your onTap functionality here
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ImpactLocation()),
                                    // );
                                    Navigator.pushNamed(
                                        context,
                                        RouteConstants
                                            .communicationPrefencesListPage);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 25,
                            left: 15,
                            right: 15), // Adjust this to position the box
                        padding: EdgeInsets.all(16.0),
                        width: 350,
                        height: 200, // Specify the height here
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
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

                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              DecorativeBox(), // Decorative container
                              Positioned(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children:
                                      List.generate(options.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Container(
                                          width: 100,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 238, 237, 237),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.grey
                                            //         .withOpacity(0.5),
                                            //     spreadRadius: 1,
                                            //     blurRadius: 3,
                                            //     offset: Offset(0,
                                            //         3), // changes position of shadow
                                            //   ),
                                            // ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                options[index]['icon'],
                                                color: selectedIndex == index
                                                    ? options[index]
                                                        ['iconColor']
                                                    : Colors
                                                        .grey, // Change icon color
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                options[index]['label'],
                                                style: TextStyle(
                                                  color: selectedIndex == index
                                                      ? options[index]
                                                          ['textColor']
                                                      : Colors
                                                          .black, // Change text color
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //_SimulateButton(language: language),

                      SizedBox(height: 25),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // _showPopup(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xff1E60AA), // Text color
                            elevation: 5, // Elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Button border radius
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 145, vertical: 18),
                          ),
                          child: Text(
                            'Launch'.toUpperCase(),
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // Text color
                            elevation: 5, // Elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Button border radius
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 138, vertical: 17),
                          ),
                          child: Text(
                            'Simulate'.toUpperCase(),
                            style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: IncidentActionTabBar(language: language),
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
}

class DecorativeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Container(
      width: 400,
      height: 154,
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
      child: Padding(
        padding: const EdgeInsets.only(left: 18, top: 5),
        child: Container(
          child: Text(
            language!.label_severity_level,
            style:
                GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
      ),
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
