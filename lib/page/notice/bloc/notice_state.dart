part of 'notice_bloc.dart';

class NoticeState extends Equatable {
  final Notices? notices;
  final NetworkStatus status;

  const NoticeState({this.notices, this.status = NetworkStatus.initial});

  NoticeState copyWith({required Notices? notices, required NetworkStatus? status}) {
    return NoticeState(notices: notices ?? this.notices, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [notices, status];
}
