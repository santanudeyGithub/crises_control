// ignore_for_file: prefer_const_constructors_in_immutables

part of 'ping_bloc.dart';

abstract class PingState extends Equatable {
  const PingState({required String customProperty});

  get customProperty => null;
}

class PingInitial extends PingState {
  PingInitial({required super.customProperty});

  @override
  List<Object?> get props => [];
}

//Ping detail state
class PingDetailsInitial extends PingState {
  const PingDetailsInitial(this.selectedPing) : super(customProperty: '');
  final MockPing selectedPing;

  @override
  List<Object?> get props => [selectedPing];
}

//Generic error state
class PingFailure extends PingState {
  const PingFailure(this.error) : super(customProperty: '');
  final CCError error;
  @override
  List<Object?> get props => [error];
}

//Ping media attachment states
class MediaAttachmentAdded extends PingState {
  const MediaAttachmentAdded(this.mediaAttachments, this.mediaCount) : super(customProperty: '');
  final List<MediaAttachment> mediaAttachments;
  final int mediaCount;

  @override
  List<Object?> get props => [mediaAttachments, mediaCount];
}
