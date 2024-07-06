import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/replies.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:equatable/equatable.dart';

part 'replies_state.dart';

class RepliesCubit extends Cubit<RepliesState> {
  RepliesCubit(this._pingRepository)
      : super(
          const RepliesState(
            [],
            false,
            null,
          ),
        );
  final PingRepository _pingRepository;

  Future<void> getReplies(int parentId) async {
    await Future.delayed(const Duration(microseconds: 1));
    emit(const RepliesState(
      [],
      true,
      null,
    ));
    final result = await _pingRepository.getReplies(parentId: parentId);

    result.fold(
      (error) => emit(RepliesState(
        const [],
        false,
        error,
      )),
      (replies) => emit(RepliesState(
        replies,
        false,
        null,
      )),
    );
  }
}
