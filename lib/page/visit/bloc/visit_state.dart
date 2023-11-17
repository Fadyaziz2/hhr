part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final NetworkStatus? status;
  final VisitListModel? visitListResponse;
  final HistoryListModel? historyListResponse;
  final String? currentDate;
  final bool? isDateEnable;

  const VisitState(
      {this.status = NetworkStatus.initial,
      this.visitListResponse,
      this.historyListResponse,
      this.currentDate,
      this.isDateEnable = false});

  VisitState copyWith(
      {NetworkStatus? status,
      VisitListModel? visitListResponse,
      HistoryListModel? historyListResponse,
      String? currentDate,
      bool? isDateEnable}) {
    return VisitState(
        status: status ?? this.status,
        visitListResponse: visitListResponse ?? this.visitListResponse,
        historyListResponse: historyListResponse ?? this.historyListResponse,
        currentDate: currentDate ?? this.currentDate,
        isDateEnable: isDateEnable ?? this.isDateEnable);
  }

  @override
  List<Object?> get props => [
        status,
        visitListResponse,
        historyListResponse,
        currentDate,
        isDateEnable
      ];
}
