part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final NetworkStatus? status;
  final VisitListModel? visitListResponse;

  const VisitState(
      {this.status = NetworkStatus.initial, this.visitListResponse});

  VisitState copyWith(
      {NetworkStatus? status, VisitListModel? visitListResponse}) {
    return VisitState(status: status ?? this.status,visitListResponse: visitListResponse ?? this.visitListResponse);
  }

  @override
  List<Object?> get props => [status,visitListResponse];
}
