// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Users extends Equatable {
  const Users({
    required this.data,
  });

  final UserResponseData data;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserResponseData extends Equatable {
  const UserResponseData({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
  });

  final int draw;
  final int recordsTotal;
  final int recordsFiltered;
  final List<UserData> data;

  factory UserResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDataToJson(this);

  @override
  List<Object?> get props => [
        draw,
        recordsTotal,
        recordsFiltered,
        data,
      ];
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserData extends Equatable {
  const UserData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.mobileISDCode,
    required this.mobileNo,
    required this.LLISDCode,
    required this.landline,
    required this.primaryEmail,
    required this.userPhoto,
    required this.userRole,
    required this.uniqueGuiID,
    required this.registerUser,
    required this.status,
    required this.updatedOn,
    required this.description,
    required this.companyId,
    required this.departmentName,
  });

  final int userId;
  final String firstName;
  final String lastName;
  final String mobileISDCode;
  final String mobileNo;
  final String? LLISDCode;
  final String? landline;
  final String primaryEmail;
  final String userPhoto;
  final UserRole userRole;
  final String uniqueGuiID;
  final bool registerUser;
  final int status;
  final DateTime updatedOn;
  final dynamic description;
  final int companyId;
  final dynamic departmentName;

  String get fullName => '$firstName $lastName';
  bool get isSuperAdmin => userRole == UserRole.SUPERADMIN;
  bool get isAdmin => userRole == UserRole.ADMIN;
  bool get isUser => userRole == UserRole.USER;
  bool get isInactive => status == 0;
  bool get isActive => status == 1;
  bool get isPending => status == 2;
  bool get isDeleted => status == 3;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        mobileISDCode,
        mobileNo,
        LLISDCode,
        landline,
        primaryEmail,
        userPhoto,
        userRole,
        uniqueGuiID,
        registerUser,
        status,
        updatedOn,
        description,
        companyId,
        departmentName,
      ];
}

enum UserRole { ADMIN, USER, KEYHOLDER, SUPERADMIN }
