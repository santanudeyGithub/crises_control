part of 'replies_cubit.dart';

class RepliesState extends Equatable {
  const RepliesState(
    this.replies,
    this.isLoading,
    this.error,
  );
  final bool isLoading;
  final CCError? error;
  final List<Reply> replies;

  @override
  List<Object?> get props => [
        replies,
        isLoading,
        error,
      ];
}
