import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User(
    this.userId,
    this.companyId,
    this.registeredUser,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.primaryEmail,
    this.secondaryEmail,
    this.uniqueGuiID,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.status,
    this.userPhoto,
    this.iSDCode,
    this.userRole,
    this.lLISDCode,
    this.landline,
    this.lat,
    this.lng,
    this.userLanguage,
    this.firstLogin,
    this.otpCode,
    this.externalScimId,
  );

  final int userId;
  final int companyId;
  final bool registeredUser;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String primaryEmail;
  final String secondaryEmail;
  final String uniqueGuiID;
  final int createdBy;
  final DateTime createdOn;
  final int updatedBy;
  final DateTime updatedOn;
  final int status;
  final String userPhoto;
  final String iSDCode;
  final String userRole;
  final String lLISDCode;
  final String landline;
  final String lat;
  final String lng;
  final String userLanguage;
  final bool firstLogin;
  final String otpCode;
  final String externalScimId;

  String get fullName {
    return "$firstName $lastName";
  }

  @override
  List<Object?> get props => [
        userId,
        userId,
        companyId,
        registeredUser,
        firstName,
        lastName,
        mobileNo,
        primaryEmail,
        secondaryEmail,
        uniqueGuiID,
        createdBy,
        createdOn,
        updatedBy,
        updatedOn,
        status,
        userPhoto,
        iSDCode,
        userRole,
        lLISDCode,
        landline,
        lat,
        lng,
        userLanguage,
        firstLogin,
        otpCode,
        externalScimId,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static List<User> mockUsers = [];
}
