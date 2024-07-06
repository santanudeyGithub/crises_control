part of 'pings_cubit.dart';

enum PingsStateActions { initial, loading, success, error, empty }

class PingsState extends Equatable {
  const PingsState(
    this.action,
    this.error,
    this.pings,
  );
  final PingsStateActions action;
  final CCError? error;
  final List<PingData> pings;

  @override
  List<Object?> get props => [action, error, pings];
}
