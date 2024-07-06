class Group {
  Group(
    this.groupId,
    this.groupName,
    this.createdBy,
    this.createdOn,
    this.updateBy,
    this.updatedOn,
    this.companyId,
    this.status,
    this.count,
  );
  final int groupId;
  final String groupName;
  final int createdBy;
  final DateTime createdOn;
  final int updateBy;
  final DateTime updatedOn;
  final int companyId;
  final int status;
  //! DELTE THIS PROPERTY AS ITS ONLY USED FOR MOCK DATA
  final int count;

  static List<Group> mockGroups = [
    Group(1, 'groupName', 1, DateTime(0), 1, DateTime(0), 1, 1, 1),
    Group(1, 'groupName', 1, DateTime(0), 1, DateTime(0), 1, 1, 1),
    Group(1, 'groupName', 1, DateTime(0), 1, DateTime(0), 1, 1, 1),
    Group(1, 'groupName', 1, DateTime(0), 1, DateTime(0), 1, 1, 1)
  ];
}
