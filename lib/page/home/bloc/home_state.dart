part of 'home_bloc.dart';

class HomeState extends Equatable{
  final Settings? settings;
  final NetworkStatus status;
  final DashboardModel? dashboardModel;

  const HomeState({this.status = NetworkStatus.initial,this.settings,this.dashboardModel});

  HomeState copy({BuildContext? context, Settings? settings, DashboardModel? dashboardModel,NetworkStatus? status}) {
    return HomeState(settings: settings ?? this.settings,status: status ?? this.status,dashboardModel: dashboardModel ?? this.dashboardModel);
  }

  @override
  List<Object?> get props => [settings,dashboardModel,status];
}
