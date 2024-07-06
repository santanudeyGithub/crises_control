import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_number.g.dart';
@JsonSerializable(fieldRename: FieldRename.pascal)
class PhoneNumberData extends Equatable{
  const PhoneNumberData({
    required this.phoneNumber,
    required this.errorId,
    required this.message,
    required this.errorCode,
    required this.statusCode,
  });

  final List<String> phoneNumber;
  final int errorId;
  final String message;
  final dynamic errorCode;
  final String statusCode;

  factory PhoneNumberData.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberDataFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberDataToJson(this);
  
  @override
  List<Object?> get props =>  [
    phoneNumber,
    errorId,
    message,
    errorCode,
    statusCode,
  ];
}
