class Incident {
  Incident(this.title, this.location, this.launchTime, this.launchSeverity);
  final String title;
  final String location;
  final String launchTime;
  final int launchSeverity;

  //MOCK DATA
  static List<Incident> mockIncidents = [
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 3),
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 5),
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 2),
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 4),
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 1),
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 5),
    Incident('Luca incident', "Luca location", '21 Aug 2022 - 09:28', 2),
  ];
}
