// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crises_control/src/core/models/user.dart';
import 'package:equatable/equatable.dart';

class AcknowledgeStatus extends Equatable {
  const AcknowledgeStatus(
    this.email, {
    required this.user,
    required this.acknowledged,
  });
  final User user;
  final bool acknowledged;
  final String email;

  static List<AcknowledgeStatus> mockData = [
    AcknowledgeStatus(
        user: User.mockUsers[0],
        acknowledged: false,
        'luca.pirolo@transputec.com'),
    AcknowledgeStatus(
        user: User.mockUsers[2],
        acknowledged: true,
        'luca.pirolo@transputec.com'),
    AcknowledgeStatus(
        user: User.mockUsers[3],
        acknowledged: false,
        'luca.pirolo@transputec.com'),
    AcknowledgeStatus(
        user: User.mockUsers[1],
        acknowledged: false,
        'luca.pirolo@transputec.com')
  ];

  @override
  List<Object?> get props => [user, acknowledged];
}
