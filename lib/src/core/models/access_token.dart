// To parse this JSON data, do
//
//     final accessToken = accessTokenFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'access_token.g.dart';

AccessToken accessTokenFromJson(String str) =>
    AccessToken.fromJson(json.decode(str));

String accessTokenToJson(AccessToken data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class AccessToken extends Equatable {
  const AccessToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String tokenType;
  @HiveField(2)
  final int expiresIn;

  AccessToken copyWith({
    required String accessToken,
    required String tokenType,
    required int expiresIn,
  }) =>
      AccessToken(
        accessToken: accessToken,
        tokenType: tokenType,
        expiresIn: expiresIn,
      );

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn];
}
