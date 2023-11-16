part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final NetworkStatus? status;
  final VisitListModel? visitListResponse;
  final HistoryListModel? historyListResponse;

  const VisitState(
      {this.status = NetworkStatus.initial, this.visitListResponse,this.historyListResponse});

  VisitState copyWith(
      {NetworkStatus? status, VisitListModel? visitListResponse,HistoryListModel? historyListResponse}) {
    return VisitState(status: status ?? this.status,visitListResponse: visitListResponse ?? this.visitListResponse,historyListResponse: historyListResponse ?? this.historyListResponse);
  }

  @override
  List<Object?> get props => [status,visitListResponse,historyListResponse];
}
