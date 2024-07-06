import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:equatable/equatable.dart';
part 'ping_event.dart';
part 'ping_state.dart';

class PingBloc extends Bloc<PingEvent, PingState> {
  PingBloc() : super(PingInitial(customProperty: '')) {
    on<SelectedPing>(_onSelectedPingEvent);
  }

  _onSelectedPingEvent(
    SelectedPing event,
    Emitter<PingState> emit,
  ) {
    emit(PingDetailsInitial(event.selectedPing));
    emit(PingInitial(customProperty: ''));
  }
}
