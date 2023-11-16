part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final NetworkStatus? status;
  final VisitListModel? visitListResponse;
  final HistoryListModel? historyListResponse;
  final String? currentDate;

  const VisitState(
      {this.status = NetworkStatus.initial,
      this.visitListResponse,
      this.historyListResponse,
      this.currentDate});

  VisitState copyWith(
      {NetworkStatus? status,
      VisitListModel? visitListResponse,
      HistoryListModel? historyListResponse,
      String? currentDate}) {
    return VisitState(
        status: status ?? this.status,
        visitListResponse: visitListResponse ?? this.visitListResponse,
        historyListResponse: historyListResponse ?? this.historyListResponse,
        currentDate: currentDate ?? this.currentDate);
  }

  @override
  List<Object?> get props =>
      [status, visitListResponse, historyListResponse, currentDate];
}
