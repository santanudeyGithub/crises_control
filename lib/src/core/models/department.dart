import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department extends Equatable {
  const Department(
    this.departmentName,
    this.userCount,
    this.departmentId,
    this.createdBy,
    this.createdOn,
    this.updateBy,
    this.updatedOn,
    this.companyId,
    this.status,
  );
  final int departmentId;
  final String? departmentName;
  final int createdBy;
  final DateTime createdOn;
  final int updateBy;
  final DateTime updatedOn;
  final int companyId;
  final int status;
   //! DELTE THIS PROPERTY AS ITS ONLY USED FOR MOCK DATA
  final int userCount;

  static List<Department> mockDepartment = [
    Department('departmentName', 3, 1, 2, DateTime(2), 1, DateTime(12), 12, 1),
    Department('departmentName', 3, 1, 2, DateTime(2), 1, DateTime(12), 12, 1),
    Department('departmentName', 3, 1, 2, DateTime(2), 1, DateTime(12), 12, 1),
    Department('departmentName', 3, 1, 2, DateTime(2), 1, DateTime(12), 12, 1),
  ];

  @override
  List<Object?> get props => [
        departmentId,
        departmentName,
        createdBy,
        createdOn,
        updateBy,
        updatedOn,
        companyId,
        status,
        userCount,
      ];
}
