// ignore_for_file: unused_local_variable, deprecated_member_use, prefer_const_constructors, use_super_parameters

import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/presentation/widgets/menu_widgets.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';
import 'package:crises_control/src/ping/cubit/new_ping_cubit.dart';
import 'package:crises_control/src/ping/models/ping_severity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewPingBody extends StatefulWidget {
  const NewPingBody({super.key, required this.selectedUsers});
  final List<SelectedUser> selectedUsers;

  @override
  State<NewPingBody> createState() => _NewPingBodyState();
}

class _NewPingBodyState extends State<NewPingBody> {
  final TextEditingController _messageTextController = TextEditingController();
  int _priorityIndex = 0;
  List<LocationsData> _selectedLocations = [];
  List<GroupData> _selectedGroups = [];
  List<SelectedUser> _selectedUsers = [];
  List<DepartmentsData> _selectedDepartments = [];
  List<SelectedCommunication> _selectedCommunicationPreferences = [];
  List<SelectedCommunication> _lowPriorityComms = [];
  List<SelectedCommunication> _mediumPriorityComms = [];
  List<SelectedCommunication> _highPriorityComms = [];
  List<MessageMethod> _allCommunicationChannels = [];
  List<CascadingPlan> _allCascadingPlans = [];
  List<AcknowledgeOption> _selectedAcknowledgeOptions = [];
  List<String> _selectedSocialIntergrations = [];
  bool _isSlientMessage = false;
  final _loadingOverlay = CCLoadingOverlay();

  @override
  void initState() {
    super.initState();
    context.read<NewPingCubit>().loadNewPingPage();
    _selectedUsers = widget.selectedUsers;
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    var coreRepository =
        RepositoryProvider.of<CrisesControlCoreRepository>(context);
    return BlocConsumer<NewPingCubit, NewPingState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  // controller:
                  //     ScrollController(initialScrollOffset: _scrollOffset),
                  children: [
                    MessageTextField(
                      textEditingController: _messageTextController,
                      onChanged: (text) {
                        setState(() {});
                      },
                      type: MessageTextFieldType.ping,
                    ),
                    ExpansionTile(
                      leading: const Icon(
                        Icons.campaign,
                        color: Palette.primary,
                      ),
                      title: const Text('Who To Notify'),
                      collapsedIconColor:
                          _getArrowColor(MenuRowType.whoToNotify),
                      iconColor: _getArrowColor(MenuRowType.whoToNotify),
                      children: [
                        MenuRow(
                          icon: Icons.place,
                          title: 'Locations',
                          imagePath: 'assets/images/Messages_icon_new.png',
                          type: MenuRowType.locations,
                          onPressed: () => _onLocationsToNotify(),
                          subtitle: ListHelpers.locationListToString(
                              _selectedLocations),
                          arrowColor: _getArrowColor(MenuRowType.locations),
                          messageType: BackendConstants.messageTypePing,
                        ),
                        MenuRow(
                          icon: Icons.groups,
                          title: 'Groups',
                          imagePath: 'assets/images/Messages_icon_new.png',
                          type: MenuRowType.groups,
                          onPressed: () => _onGroupsToNotify(),
                          subtitle:
                              ListHelpers.groupListToString(_selectedGroups),
                          arrowColor: _getArrowColor(MenuRowType.groups),
                          messageType: BackendConstants.messageTypePing,
                        ),
                        MenuRow(
                          icon: Icons.reduce_capacity,
                          title: 'Departments',
                          imagePath: 'assets/images/Messages_icon_new.png',
                          type: MenuRowType.departments,
                          onPressed: () => _onDepartmentsToNotify(),
                          subtitle: ListHelpers.departmentListToString(
                              _selectedDepartments),
                          arrowColor: _getArrowColor(MenuRowType.departments),
                          messageType: BackendConstants.messageTypePing,
                        ),
                        MenuRow(
                          icon: Icons.person,
                          title: 'Users',
                          imagePath: 'assets/images/Messages_icon_new.png',
                          type: MenuRowType.users,
                          onPressed: () => _onUsersToNotify(),
                          subtitle: ListHelpers.selectedUserListToString(
                              _selectedUsers),
                          arrowColor: _getArrowColor(MenuRowType.users),
                          messageType: BackendConstants.messageTypePing,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(language!.label_advanced_options),
                      leading: const Icon(Icons.settings),
                      collapsedIconColor: Palette.primary,
                      children: [
                        Visibility(
                          visible: coreRepository
                              .checkMenuAccess(SecItemKeys.pingAudioMessage),
                          child: AdvancedOptionTile(
                            title: language.label_audio_message,
                            imagePath: 'assets/images/advaceoptions.png',
                            onTapped: () {},
                            icon: Icons.lyrics,
                          ),
                        ),
                        Visibility(
                          visible: coreRepository
                              .getCompanyParamValue(
                                  CompanyParamKeys.allowSocialPosting)
                              .toBool(),
                          child: AdvancedOptionTile(
                            title: language.label_social_post,
                            imagePath: 'assets/images/advaceoptions.png',
                            onTapped: _onSocialIntergrations,
                            icon: Icons.post_add,
                          ),
                        ),
                        Visibility(
                          visible: coreRepository
                              .checkMenuAccess(SecItemKeys.pingAckOptions),
                          child: AdvancedOptionTile(
                            title: language.label_acknowledge_options,
                            imagePath: 'assets/images/advaceoptions.png',
                            onTapped: () {
                              _onAcknowledgeOptions();
                            },
                            icon: Icons.checklist,
                            subtitle:
                                ListHelpers.acknowledgeOptionsListToString(
                              _selectedAcknowledgeOptions,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(language.label_silent_message),
                          leading: const Icon(Icons.volume_off),
                          iconColor: Palette.primary,
                          trailing: Switch(
                            value: _isSlientMessage,
                            onChanged: (value) {
                              setState(() {
                                _isSlientMessage = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      trailing: const Icon(Icons.navigate_next),
                      title: Text(language.myaccount_comm_prefs),
                      subtitle: Text(
                        ListHelpers.selectedMessageMethodListToString(
                          _selectedCommunicationPreferences,
                        ),
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      leading: const Icon(
                        Icons.podcasts,
                        color: Palette.primary,
                      ),
                      iconColor:
                          _getArrowColor(MenuRowType.communicationPreferences),
                      onTap: _onCommunicationPreferences,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Priority:',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Wrap(
                              children: List<Widget>.generate(
                            3,
                            (int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ChoiceChip(
                                  label: Text(
                                    PriorityHelper.pingIndexToPriorityLabel(
                                        index, context),
                                  ),
                                  selected: _priorityIndex == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _priorityIndex = selected ? index : 0;
                                      bool allowChannelPrioritySetup =
                                          coreRepository
                                              .getCompanyParamValue(
                                                  CompanyParamKeys
                                                      .allowChannelPrioritySetup)
                                              .toBool();
                                      if (allowChannelPrioritySetup) {
                                        switch (index) {
                                          case 0:
                                            _selectedCommunicationPreferences =
                                                _lowPriorityComms;
                                            break;
                                          case 1:
                                            _selectedCommunicationPreferences =
                                                _mediumPriorityComms;
                                            break;
                                          case 2:
                                            _selectedCommunicationPreferences =
                                                _highPriorityComms;
                                            break;
                                          default:
                                        }
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ).toList()),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              _SendMessage(
                selectedCommunicationPreferences:
                    _selectedCommunicationPreferences,
                message: _messageTextController.text,
                selectedDepartments: _selectedDepartments,
                selectedLocations: _selectedLocations,
                selectedGroups: _selectedGroups,
                selectedUsers: _selectedUsers,
                selectedAcknowledgeOptions: _selectedAcknowledgeOptions,
                isSlientMessage: _isSlientMessage,
                priorityIndex: _priorityIndex,
              ),
            ],
          ),
        );
      },
    );
  }

  _handleStateChanges(context, state) {
    var language = AppLocalizations.of(context);
    var coreRepository =
        RepositoryProvider.of<CrisesControlCoreRepository>(context);

    if (state is NewPingLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }

    if (state is NewPingErrorPop) {
      showDialog(
        context: context,
        builder: (context) => state.error.displayErrorAlerts(context),
      );
      Navigator.pop(context);
    }
    if (state is NewPingError) {
      showDialog(
        context: context,
        builder: (context) => state.error.displayErrorAlerts(context),
      );
    }

    if (state is NewPingLoaded) {
      bool allowChannelPrioritySetup = coreRepository
          .getCompanyParamValue(CompanyParamKeys.allowChannelPrioritySetup)
          .toBool();
      if (allowChannelPrioritySetup) {
        //Map Priority to CommMethods (if enabled in company param)
        var defaultCommunicationPreferences = state.messageMethods
            .map((mm) => mm.toSelectedCommunication())
            .toList();
        _selectedCommunicationPreferences = state.lowPriorityMethods.isNotEmpty
            ? state.lowPriorityMethods
            : defaultCommunicationPreferences;
        _lowPriorityComms = state.lowPriorityMethods;
        _mediumPriorityComms = state.mediumPriorityMethods;
        _highPriorityComms = state.highPriorityMethods;
      }
      _allCommunicationChannels = state.messageMethods;
      _allCascadingPlans = state.cascadingPlans;

      if (state.hasLowBalance != null && state.hasLowBalance!.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => CCAlertDialog(
            title: state.hasLowBalance,
            description: state.hasLowBalance,
            actions: const [
              OkAlertButton(),
            ],
          ),
        );
      }
    }

    if (state is NewPingLaunched) {
      showDialog(
        context: context,
        builder: (context) => CCAlertDialog(
          title: "Success",
          description: "Ping launched successfully",
          actions: const [
            OkAlertButton(),
          ],
        ),
      );
    }
  }

  Color _getArrowColor(MenuRowType menuRowType) {
    var validColor = Palette.primary;
    var invalidColor = Palette.primaryRedColor;
    switch (menuRowType) {
      case MenuRowType.whoToNotify:
      case MenuRowType.locations:
      case MenuRowType.groups:
      case MenuRowType.departments:
      case MenuRowType.users:
        return _isWhoToNotifyValid() ? validColor : invalidColor;
      case MenuRowType.communicationPreferences:
        return _selectedCommunicationPreferences.isNotEmpty
            ? validColor
            : invalidColor;
      default:
        return validColor;
    }
  }

  bool _isWhoToNotifyValid() {
    if (_selectedLocations.isNotEmpty ||
        _selectedGroups.isNotEmpty ||
        _selectedDepartments.isNotEmpty ||
        _selectedUsers.isNotEmpty) {
      return true;
    }
    return false;
  }

  //Navigation methods
  _onUsersToNotify() async {
    final users = await Navigator.pushNamed(
      context,
      RouteConstants.userListPage,
      arguments: UserListPageArguments(false, _selectedUsers),
    ) as List<SelectedUser>;
    setState(
      () {
        _selectedUsers = users;
      },
    );
  }

  _onGroupsToNotify() async {
    final groups = await Navigator.pushNamed(
      context,
      RouteConstants.groupListPage,
      arguments: GroupListPageArguments(
        _selectedGroups,
      ),
    ) as List<GroupData>;
    setState(
      () {
        _selectedGroups = groups;
      },
    );
  }

  _onAcknowledgeOptions() async {
    final acknowledgeOptions = await Navigator.pushNamed(
      context,
      RouteConstants.acknowledgeOptionsListPage,
      arguments: AcknowledgeOptionsListPageArguments(
        _selectedAcknowledgeOptions,
        'Ping',
        1,
      ),
    ) as List<AcknowledgeOption>;
    setState(
      () {
        _selectedAcknowledgeOptions = acknowledgeOptions;
      },
    );
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

  _onDepartmentsToNotify() async {
    final departments = await Navigator.pushNamed(
      context,
      RouteConstants.departmentListPage,
      arguments: DepartmentListPageArguments(
        _selectedDepartments,
      ),
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
}

class AdvancedOptionTile extends StatelessWidget {
  const AdvancedOptionTile({
    Key? key,
    required this.title,
    required this.onTapped,
    required this.icon,
    required this.imagePath,
    this.subtitle = '',
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTapped;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Image.asset(
        imagePath,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: onTapped,
      iconColor: Palette.primary,
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.apply(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
    );
  }
}

class _SendMessage extends StatelessWidget {
  const _SendMessage(
      {Key? key,
      required this.selectedCommunicationPreferences,
      required this.message,
      required this.selectedDepartments,
      required this.selectedGroups,
      required this.selectedLocations,
      required this.selectedUsers,
      required this.selectedAcknowledgeOptions,
      required this.isSlientMessage,
      required this.priorityIndex})
      : super(key: key);
  final List<SelectedCommunication> selectedCommunicationPreferences;
  final List<DepartmentsData> selectedDepartments;
  final List<GroupData> selectedGroups;
  final List<LocationsData> selectedLocations;
  final String message;
  final List<SelectedUser> selectedUsers;
  final List<AcknowledgeOption> selectedAcknowledgeOptions;
  final bool isSlientMessage;
  final int priorityIndex;

  @override
  Widget build(BuildContext context) {
    var isSubmittedFormDataValid = false;
    if (message.isNotEmpty &&
        (selectedLocations.isNotEmpty ||
            selectedGroups.isNotEmpty ||
            selectedDepartments.isNotEmpty ||
            selectedUsers.isNotEmpty) &&
        selectedCommunicationPreferences.isNotEmpty) {
      isSubmittedFormDataValid = true;
    }

    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: isSubmittedFormDataValid
              ? Palette.primary
              : Palette.disabledBackgroundColor,
          foregroundColor: isSubmittedFormDataValid
              ? Palette.enabledTextColor
              : Palette.disabledTextColor,
        ),
        onPressed: (() {
          //Frontend validation
          if (!isSubmittedFormDataValid) {
            showDialog(
              context: context,
              builder: (context) => const CCAlertDialog(
                title: "Please fill in all the required fields and message",
                description:
                    "Please fill in the fields that have red arrow next to it and ensure that you have entered the message.",
                actions: [
                  OkAlertButton(),
                ],
              ),
            );
          } else {
            context.read<NewPingCubit>().sendPing(
                  ackOptions: selectedAcknowledgeOptions,
                  message: message,
                  selectedCommunicationMethods:
                      selectedCommunicationPreferences,
                  userToNotify: selectedUsers,
                  departments: selectedDepartments,
                  groups: selectedGroups,
                  locations: selectedLocations,
                  isSlientMessage: isSlientMessage,
                  priorityIndex: priorityIndex,
                );
          }
        }),
        child: const Text(
          'Send Message',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
