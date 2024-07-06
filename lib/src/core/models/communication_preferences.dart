class CommunicationPreference {
  CommunicationPreference(this.methodName, this.communicationPreferenceType);
  final String methodName;
  final CommunicationPreferenceType communicationPreferenceType;

  static List<CommunicationPreference> mockData = [
    CommunicationPreference('Push', CommunicationPreferenceType.push),
    CommunicationPreference('Text', CommunicationPreferenceType.text),
    CommunicationPreference('Phone', CommunicationPreferenceType.phone),
    CommunicationPreference('Email', CommunicationPreferenceType.email),
  ];
}

enum CommunicationPreferenceType { push, text, phone, email }

