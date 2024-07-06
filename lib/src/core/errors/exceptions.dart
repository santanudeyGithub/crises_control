import 'dart:convert';

class ServerException implements Exception {
  ServerException({this.excepetionMessage = ''});
  final String excepetionMessage;
}

class UnauthorisedException implements Exception {
  UnauthorisedException(
      {this.errorId = 'e009', this.errorTitle = 'Login Failure'});
  final String errorId;
  final String errorTitle;
}

class HttpStatusCodeErrorException implements Exception {
  HttpStatusCodeErrorException(
      {this.errorId = 'f100', this.errorTitle = 'Unable to process request, please try again later.', this.statusCode});
  final String errorId;
  final String errorTitle;
  final int? statusCode;
}

///This object represents the error object the API returns
ApiException apiExceptionFromJson(String str) =>
    ApiException.fromJson(json.decode(str));
String apiExceptionToJson(ApiException data) => json.encode(data.toJson());

class ApiException {
  factory ApiException.fromJson(Map<String, dynamic> json) => ApiException(
        errorId: json['ErrorId'],
        errorCode: json['ErrorCode'],
        message: json['Message'],
      );
  ApiException({
    required this.errorId,
    required this.errorCode,
    required this.message,
  });

  int errorId;
  String errorCode;
  String message;

  ApiException copyWith({
    required int errorId,
    required String errorCode,
    required String message,
  }) =>
      ApiException(
        errorId: errorId,
        errorCode: errorCode,
        message: message,
      );

  Map<String, dynamic> toJson() => {
        'ErrorId': errorId,
        'ErrorCode': errorCode,
        'Message': message,
      };
}

class UrlLauncherException implements Exception {}
