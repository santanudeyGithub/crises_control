import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';

class ListHelpers {
  static List<SelectedCommunication> getPriorityForCommsResponse({
    required CompanyCommsResponse data,
    required int priorityLevel,
    required String messageType,
  }) {
    for (var element in data.data.priorityMethod) {
      if (element.priorityLevel == priorityLevel &&
          element.messageType == messageType) {
        List<int> methods = element.methods.split(",").map(int.parse).toList();
        var severityList = data.data.objectInfo
            .where(
              (element) =>
                  methods.contains(element.methodId) &&
                  element.serviceStatus == true,
            )
            .toList();
        List<SelectedCommunication> selectedCommunication = [];

        for (var element in severityList) {
          selectedCommunication.add(
            SelectedCommunication(
              element.methodId,
              element.methodName,
              false,
            ),
          );
        }
        return selectedCommunication;
      }
    }
    return [];
  }
}
