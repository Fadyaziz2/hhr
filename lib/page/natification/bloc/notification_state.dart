part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final NotificationResponse? notificationResponse;
  final NetworkStatus status;

  const NotificationState(
      {this.notificationResponse, this.status = NetworkStatus.initial});

  NotificationState copy(
      {BuildContext? context,
      NotificationResponse? notificationResponse,
      NetworkStatus? status}) {
    return NotificationState(
        notificationResponse: notificationResponse,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [notificationResponse];
}
