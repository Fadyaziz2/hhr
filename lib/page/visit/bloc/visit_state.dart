part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final NetworkStatus? status;
  final VisitListModel? visitListResponse;
  final HistoryListModel? historyListResponse;
  final String? currentDate;
  final String? currentMonth;
  final bool? isDateEnable;
  final VisitDetailsModel? visitDetailsResponse;
  List? locationListServer = [];

  VisitState(
      {this.status = NetworkStatus.initial,
      this.visitListResponse,
      this.historyListResponse,
      this.currentDate,
      this.currentMonth,
      this.visitDetailsResponse,
      this.locationListServer,
      this.isDateEnable = false});

  VisitState copyWith(
      {NetworkStatus? status,
      VisitListModel? visitListResponse,
      HistoryListModel? historyListResponse,
      String? currentDate,
      String? currentMonth,
      List? locationListServer,
      VisitDetailsModel? visitDetailsResponse,
      bool? isDateEnable}) {
    return VisitState(
        status: status ?? this.status,
        visitListResponse: visitListResponse ?? this.visitListResponse,
        visitDetailsResponse: visitDetailsResponse ?? this.visitDetailsResponse,
        historyListResponse: historyListResponse ?? this.historyListResponse,
        currentDate: currentDate ?? this.currentDate,
        currentMonth: currentMonth ?? this.currentMonth,
        locationListServer: locationListServer ?? this.locationListServer,
        isDateEnable: isDateEnable ?? this.isDateEnable);
  }

  @override
  List<Object?> get props => [
        status,
        visitListResponse,
        historyListResponse,
        currentDate,
        isDateEnable,
        currentMonth,
        visitDetailsResponse
      ];
}
