part of 'ping_bloc.dart';

abstract class PingEvent extends Equatable {
  const PingEvent();
}

//This event happens when a user selects a ping on ping list page
class SelectedPing extends PingEvent {
  const SelectedPing(this.selectedPing);
  final MockPing selectedPing;

  @override
  List<Object> get props => [selectedPing];
}

//Ping media attachment events
class TakePictureTapped extends PingEvent {
  const TakePictureTapped({
    required this.isVideo,
    required this.fromGallery,
    required this.saveToGallery,
  });
  final bool isVideo;
  final bool fromGallery;
  final bool saveToGallery;

  @override
  List<Object?> get props => [isVideo, fromGallery, saveToGallery];
}
