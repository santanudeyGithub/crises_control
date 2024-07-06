import 'package:json_annotation/json_annotation.dart';

part 'password_otp_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PasswordOtpResponse {
    PasswordOtpResponse({
        required this.message,
    });

    String? message;

    factory PasswordOtpResponse.fromJson(Map<String, dynamic> json) => _$PasswordOtpResponseFromJson(json);
    Map<String, dynamic> toJson() => _$PasswordOtpResponseToJson(this);
}