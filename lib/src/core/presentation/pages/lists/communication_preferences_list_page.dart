// ignore_for_file: deprecated_member_use

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/utils/converters/icon_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunicationPreferencesListPage extends StatefulWidget {
  const CommunicationPreferencesListPage(
      {super.key,
      required this.selectedCommunicationPreferences,
      required this.allCommunicationPreferences,
      required this.allCascadingPlans});
  final List<SelectedCommunication> selectedCommunicationPreferences;
  final List<MessageMethod> allCommunicationPreferences;
  final List<CascadingPlan> allCascadingPlans;

  @override
  State<CommunicationPreferencesListPage> createState() =>
      _CommunicationPreferencesListState();
}

class _CommunicationPreferencesListState
    extends State<CommunicationPreferencesListPage> {
  List<SelectedCommunication> _selectedCommunicationPreferences = [];
  List<MessageMethod> _allMessageMethods = [];
  List<CascadingPlan> _allCascadingPlans = [];

  @override
  void initState() {
    super.initState();
    _selectedCommunicationPreferences = widget.selectedCommunicationPreferences;
    _allMessageMethods = widget.allCommunicationPreferences;
    _allCascadingPlans = widget.allCascadingPlans;
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      // appBar: AppBar(
      // title: Text(language!.myaccount_comm_prefs),
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(title: language!.myaccount_comm_prefs),
          ),
          Positioned(
            top: 135, // Adjust to control the overlap
            left: 10,
            right: 10,
            bottom: 20,
            child: Column(
              children: [
                Expanded(
                  child: WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context, _selectedCommunicationPreferences);
                      return true;
                    },
                    child: Container(
                      // color: Palette.primary,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 65),
                            // child: Text(
                            //   language.communication_channels,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .labelLarge
                            //       ?.apply(color: Colors.white),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 135, bottom: 15, right: 15, left: 15),
            child: Positioned(
              child: Container(
                height: 320,
                margin: const EdgeInsets.only(top: 20, left: 0, right: 0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 120, left: 0, top: 15, bottom: 0),
                      child: Text(
                        language.communication_channels,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.apply(color: Color(0xff1E60AA)),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: _allMessageMethods.length,
                          itemBuilder: ((context, index) {
                            var communicationMethod = _allMessageMethods[index];
                            var isSelected = _selectedCommunicationPreferences
                                .where((e) =>
                                    e.id == communicationMethod.methodId &&
                                    e.isCascadingPlan == false)
                                .isNotEmpty;

                            return SelectionListTile(
                              prefixIcon: IconConverter.messageMethodIdToIcon(
                                communicationMethod.methodId,
                              ),
                              title: communicationMethod.methodName,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  _selectedCommunicationPreferences
                                      .removeWhere((e) => e.isCascadingPlan);
                                  if (isSelected) {
                                    _selectedCommunicationPreferences
                                        .removeWhere(
                                      (element) =>
                                          element.id ==
                                          communicationMethod.methodId,
                                    );
                                  } else {
                                    setState(() {
                                      _selectedCommunicationPreferences.add(
                                        SelectedCommunication(
                                          communicationMethod.methodId,
                                          communicationMethod.methodName,
                                          false,
                                        ),
                                      );
                                    });
                                  }
                                });
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 498, bottom: 15, right: 15, left: 15),
            child: Positioned(
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(top: 20, left: 0, right: 0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 185, left: 0, top: 0, bottom: 0),
                      child: Visibility(
                        visible: _allCascadingPlans.isNotEmpty,
                        child: Text(
                          language.cascading_title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.apply(color: Color(0xff1E60AA)),
                        ),
                      ),
                    ),
                    Container(
                      child: Visibility(
                        visible: _allCascadingPlans.isNotEmpty,
                        child: Expanded(
                          flex: 2,
                          child: ListView.builder(
                            itemCount: _allCascadingPlans.length,
                            itemBuilder: ((context, index) {
                              var cascadingPlan = _allCascadingPlans[index];
                              var isSelected = _selectedCommunicationPreferences
                                  .where(
                                    (e) =>
                                        e.id == cascadingPlan.planId &&
                                        e.isCascadingPlan,
                                  )
                                  .isNotEmpty;
                              return SelectionListTile(
                                title: cascadingPlan.planName,
                                isSelected: isSelected,
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedCommunicationPreferences.clear();
                                    } else {
                                      _selectedCommunicationPreferences.clear();
                                      _selectedCommunicationPreferences.add(
                                        SelectedCommunication(
                                          cascadingPlan.planId,
                                          cascadingPlan.planName,
                                          true,
                                        ),
                                      );
                                    }
                                  });
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 795, bottom: 0, left: 10, right: 0),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context, _selectedDepartments);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff1E60AA), // Text color
                elevation: 5, // Elevation
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Button border radius
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 173, vertical: 18),
              ),
              child: Text(
                'Done'.toUpperCase(),
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
