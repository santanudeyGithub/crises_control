import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'created_by.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CreatedByName extends Equatable {
  const CreatedByName({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory CreatedByName.fromJson(Map<String, dynamic> json) =>
      _$CreatedByNameFromJson(json);
  Map<String, dynamic> toJson() => _$CreatedByNameToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}
