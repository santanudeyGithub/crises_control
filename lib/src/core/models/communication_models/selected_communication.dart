import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';

class SelectedCommunication {
  SelectedCommunication(this.id, this.name, this.isCascadingPlan);

  final int id;
  final String name;
  final bool isCascadingPlan;

  MessageMethod toMessageMethod() {
    return MessageMethod(
        methodId: id, serviceStatus: true, status: 1, methodName: name);
  }
}
