import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sent_by.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SentBy extends Equatable {
  const SentBy({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory SentBy.fromJson(Map<String, dynamic> json) => _$SentByFromJson(json);

  Map<String, dynamic> toJson() => _$SentByToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}
