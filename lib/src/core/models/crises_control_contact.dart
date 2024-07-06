// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'crises_control_contact.g.dart';

@HiveType(typeId: 5)
class CrisesControlContact extends Equatable {
  const CrisesControlContact({
    required this.id,
    required this.displayName,
    required this.phoneNumbers,
    required this.phoneContactLogoUrl,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String displayName;
  @HiveField(2)
  final List<String> phoneNumbers;
  @HiveField(3)
  final String phoneContactLogoUrl;

  @override
  List<Object?> get props => [
        id,
        displayName,
        phoneNumbers,
        phoneContactLogoUrl,
      ];

  CrisesControlContact copyWith({
    String? id,
    String? displayName,
    List<String>? phoneNumbers,
    String? phoneContactLogoUrl,
  }) {
    return CrisesControlContact(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      phoneContactLogoUrl: phoneContactLogoUrl ?? this.phoneContactLogoUrl,
    );
  }
}
