part of 'attendane_method_bloc.dart';

class MenuState extends Equatable {
  final NetworkStatus status;
  final String? slugName;

  const MenuState({this.slugName, this.status = NetworkStatus.initial});

  MenuState copy(
      {BuildContext? context,
      NotificationResponse? notificationResponse,
      String? slugName,
      NetworkStatus? status}) {
    return MenuState(
        status: status ?? this.status, slugName: slugName ?? this.slugName);
  }

  @override
  List<Object?> get props => [slugName, status];
}
