// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:equatable/equatable.dart';

part 'pings_state.dart';

class PingsCubit extends Cubit<PingsState> {
  PingsCubit(this._pingRepository)
      : super(
          const PingsState(PingsStateActions.initial, null, []),
        );
  final PingRepository _pingRepository;
  final List<PingData> _pings = [];

  void loadAllPings({bool isRefresh = false}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    if (!isRefresh) {
      emit(PingsState(PingsStateActions.loading, null, _pings));
    }
    var result = await _pingRepository.getPings();
    result.fold(
      (error) => handleGetPingsError(error),
      (response) => handleGetPingsSuccess(response),
    );
  }

  void handleGetPingsSuccess(PingResponse response) {
    if (response.data.isEmpty) {
      emit(const PingsState(PingsStateActions.empty, null, []));
    }
    //sort response data by date
    response.data.sort((a, b) => b.createdOn.compareTo(a.createdOn));
    emit(PingsState(PingsStateActions.success, null, response.data));
  }

  void handleGetPingsError(CCError error) {
    final cachedPings = _pingRepository.getPingsFromCache();
    emit(PingsState(PingsStateActions.error, error, cachedPings));
  }

  void getPingInfo({required int messageId}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    var result = await _pingRepository.getPingInfo(messageId: messageId);
  }
}
