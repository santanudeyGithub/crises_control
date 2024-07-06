import 'package:crises_control/src/core/models/login_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_verify_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LoginVerifyResponse {
    LoginVerifyResponse({
        required this.data,
        required this.errorId,
        required this.message,
        required this.errorCode,
        required this.statusCode,
    });

    LoginData data;
    int? errorId;
    String? message;
    String? errorCode;
    String? statusCode;

    factory LoginVerifyResponse.fromJson(Map<String, dynamic> json) => _$LoginVerifyResponseFromJson(json);
    Map<String, dynamic> toJson() => _$LoginVerifyResponseToJson(this);
}