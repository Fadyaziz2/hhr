part of "meeting_bloc.dart";

class MeetingState extends Equatable {
  final NetworkStatus? status;
  final MeetingsListModel? meetingsListResponse;
  final String? currentMonth;
  final String? currentMonthSchedule;
  final String? startTime;
  final String? endTime;

  const MeetingState(
      {this.status = NetworkStatus.initial,
      this.meetingsListResponse,
      this.startTime,
      this.endTime,
      this.currentMonth,
      this.currentMonthSchedule});

  MeetingState copyWith(
      {NetworkStatus? status,
      String? startTime,
      String? endTime,
      MeetingsListModel? meetingsListResponse,
      String? currentMonth,
      String? currentMonthSchedule}) {
    return MeetingState(
        status: status ?? this.status,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        meetingsListResponse: meetingsListResponse ?? this.meetingsListResponse,
        currentMonth: currentMonth ?? this.currentMonth,
        currentMonthSchedule: currentMonthSchedule ?? this.currentMonthSchedule);
  }

  @override
  List<Object?> get props => [
        status,
        meetingsListResponse,
        currentMonth,
        startTime,
        endTime,
        currentMonthSchedule
      ];
}
