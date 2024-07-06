class IncidentMessage {
  IncidentMessage(this.message, this.date, this.sender, this.isAcknowledged);
  final String message;
  final String date;
  final String sender;
  final bool isAcknowledged;

  static List<IncidentMessage> mockIncidentMessages = [
    IncidentMessage(
      'This a test message for incident',
      '8 Sep 2022 - 17:56',
      'Luca Pirolo',
      false,
    ),
    IncidentMessage(
      'This a test message for incident',
      '8 Sep 2022 - 17:56',
      'Luca Pirolo',
      false,
    ),
    IncidentMessage(
      'This a test message for incident',
      '8 Sep 2022 - 17:56',
      'Luca Pirolo',
      true,
    ),
    IncidentMessage(
      'This a test 2 message for incident',
      '8 Sep 2022 - 17:56',
      'Luca Pirolo',
      true,
    )
  ];
}
