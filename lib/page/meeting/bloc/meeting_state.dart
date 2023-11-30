part of "meeting_bloc.dart";

class MeetingState extends Equatable {
  final NetworkStatus? status;
  final MeetingsListModel? meetingsListResponse;

  const MeetingState(
      {this.status = NetworkStatus.initial, this.meetingsListResponse});

  MeetingState copyWith(
      {NetworkStatus? status, MeetingsListModel? meetingsListResponse}) {
    return MeetingState(
        status: status ?? this.status,
        meetingsListResponse:
            meetingsListResponse ?? this.meetingsListResponse);
  }

  @override
  List<Object?> get props => [status, meetingsListResponse];
}
