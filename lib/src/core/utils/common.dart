import 'package:collection/collection.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/models/audio_message.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/list_models/users.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:flutter/material.dart';

void showAboutCrisesControlDialog(BuildContext context) {
  return showAboutDialog(
    context: context,
    applicationIcon: const CrisesControlLogoView(
      width: 70,
      height: 70,
    ),
    applicationName: 'Crises Control',
    applicationVersion: CrisesControlVersions.appVersion,
    applicationLegalese: 'Copyright © Transputec Ltd, 2022',
  );
}

class StringHelpers {
  static String getInitials(String name) {
    final List<String> names = name.split(' ');
    if (names.length == 1) {
      return names[0].substring(0, 2);
    }
    return names[0].substring(0, 1) + names[1].substring(0, 1);
  }

  static List<int> csvToIntArray(String? csv, [String delimiter = ',']) {
    if (csv == null || csv.isEmpty) return [];
    var stringList = csv.split(delimiter);
    List<int> intList = [];
    for (var str in stringList) {
      var intValue = int.tryParse(str);
      if (intValue != null) {
        intList.add(intValue);
      }
    }
    return intList;
  }
}

class ListHelpers {
  static List<SelectedCommunication> getCommsForPriority({
    required CompanyCommsResponse data,
    required int priorityLevel,
    required messageType,
  }) {
    List<SelectedCommunication> selectedCommunication = [];
    var priorityMethod = data.data.priorityMethod.firstWhereOrNull((pm) =>
        pm.priorityLevel == priorityLevel && pm.messageType == messageType);
    if (priorityMethod == null) return selectedCommunication;
    List<int> methodIdList =
        StringHelpers.csvToIntArray(priorityMethod.methods);
    for (var commMethod in data.data.objectInfo) {
      if (methodIdList.contains(commMethod.methodId) &&
          commMethod.serviceStatus) {
        selectedCommunication.add(
          SelectedCommunication(
            commMethod.methodId,
            commMethod.methodName,
            false,
          ),
        );
      }
    }
    return selectedCommunication;
  }

  static String locationListToString(List<LocationsData> list) {
    //sort list alphabetically
    list.sort((a, b) => a.locationName.compareTo(b.locationName));
    var string = '';
    for (var item in list) {
      string += "${item.locationName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String affectedLocationListToString(List<AffectedLocationsData> list) {
    //sort list alphabetically
    list.sort((a, b) => a.locationName.compareTo(b.locationName));
    var string = '';
    for (var item in list) {
      string += "${item.locationName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String groupListToString(List<GroupData> list) {
    //sort list alphabetically
    list.sort((a, b) => a.groupName.compareTo(b.groupName));
    var string = '';
    for (var item in list) {
      string += "${item.groupName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String userListToString(List<UserData> list) {
    //sort list alphabetically
    list.sort((a, b) => a.fullName.compareTo(b.fullName));
    var string = '';
    for (var item in list) {
      string += "${item.firstName} ${item.lastName} , ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String departmentListToString(List<DepartmentsData> list) {
    //sort list alphabetically
    list.sort((a, b) => a.departmentName.compareTo(b.departmentName));
    var string = '';
    for (var item in list) {
      string += "${item.departmentName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String messsageMethodsListToString(
    List<MessageMethod?> list,
  ) {
    //sort list alphabetically
    list.sort((a, b) => a!.methodName.compareTo(b!.methodName));
    var string = '';
    for (var item in list) {
      string += "${item!.methodName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String selectedMessageMethodListToString(
    List<SelectedCommunication?> list,
  ) {
    //sort list alphabetically
    list.sort((a, b) => a!.name.compareTo(b!.name));
    var string = '';
    for (var item in list) {
      string += "${item!.name}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String stringListToString(List<String> list) {
    //sort list alphabetically
    list.sort((a, b) => a.compareTo(b));
    var string = '';
    for (var item in list) {
      string += "$item, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String acknowledgeOptionsListToString(List<AcknowledgeOption> list) {
    //sort list alphabetically
    list.sort((a, b) => a.responseLabel.compareTo(b.responseLabel));
    var string = '';
    for (var item in list) {
      string += "${item.responseLabel}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String audioMessageListToString(List<AudioMessage> list) {
    //sort list alphabetically
    list.sort((a, b) => a.audioMessageTitle.compareTo(b.audioMessageTitle));
    var string = '';
    for (var item in list) {
      string += "${item.audioMessageTitle}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static String incKeyContactsListToString(List<IncKeyCon> list) {
    //sort list alphabetically
    list.sort((a, b) => a.fullName.compareTo(b.fullName));
    var string = '';
    for (var item in list) {
      string += "${item.fullName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }

  static List<SelectedUser> incKeyContactsListToSelectedUser(
      List<IncKeyCon> list) {
    //turn list into a list of ids
    List<SelectedUser> ids = [];
    for (var item in list) {
      ids.add(SelectedUser(item.userId, item.fullName));
    }

    return ids;
  }

  static String selectedUserListToString(List<SelectedUser> list) {
    list.sort((a, b) => a.fullName.compareTo(b.fullName));
    var string = '';
    for (var item in list) {
      string += "${item.fullName}, ";
    }
    if (string.length > 2) {
      return string.substring(0, string.length - 2);
    }
    return string;
  }
}
