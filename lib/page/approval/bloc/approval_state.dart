part of 'approval_bloc.dart';

class ApprovalState extends Equatable {
  final NetworkStatus status;
  final bool? isLoading;
  final ApprovalModel? approval;

  const ApprovalState(
      {required this.status, this.isLoading = true, this.approval});

  ApprovalState copyWith(
      {NetworkStatus? status, bool? isLoading, ApprovalModel? approval}) {
    return ApprovalState(
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading,
        approval: approval ?? this.approval);
  }

  @override
  List<Object?> get props => [status, isLoading, approval];
}
