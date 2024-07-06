import 'package:json_annotation/json_annotation.dart';
part 'api_url.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ApiUrl {
  ApiUrl({
    required this.apiUrl,
    required this.errorId,
    required this.errorCode,
    required this.message,
  });

  final int? errorId;
  final String? errorCode;
  final String? message;
  final String? apiUrl;

  factory ApiUrl.fromJson(Map<String, dynamic> json) => _$ApiUrlFromJson(json);
  Map<String, dynamic> toJson() => _$ApiUrlToJson(this);
}
