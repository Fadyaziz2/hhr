part of 'visit_bloc.dart';

class VisitState extends Equatable {
  final NetworkStatus? status;
  final VisitListModel? visitListResponse;
  final HistoryListModel? historyListResponse;
  final String? currentDate;
  final String? currentMonth;
  final bool? isDateEnable;
  final VisitDetailsModel? visitDetailsResponse;
  final Set<Marker> markers;
  final double? longitude;
  final double? latitude;

  const VisitState(
      {this.status = NetworkStatus.initial,
      this.visitListResponse,
      this.historyListResponse,
      this.currentDate,
      this.currentMonth,
      this.visitDetailsResponse,
      this.longitude,
      this.latitude,
      this.markers = const {},
      this.isDateEnable = false});

  VisitState copyWith(
      {NetworkStatus? status,
      VisitListModel? visitListResponse,
      HistoryListModel? historyListResponse,
      String? currentDate,
      String? currentMonth,
      Set<Marker>? markers,
      double? latitude,
      double? longitude,
      VisitDetailsModel? visitDetailsResponse,
      bool? isDateEnable}) {
    return VisitState(
      latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        status: status ?? this.status,
        markers: markers ?? this.markers,
        visitListResponse: visitListResponse ?? this.visitListResponse,
        visitDetailsResponse: visitDetailsResponse ?? this.visitDetailsResponse,
        historyListResponse: historyListResponse ?? this.historyListResponse,
        currentDate: currentDate ?? this.currentDate,
        currentMonth: currentMonth ?? this.currentMonth,
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
        visitDetailsResponse,
        markers
      ];
}
