part of 'home_bloc.dart';

class HomeState extends Equatable{
  final Settings? settings;
  final NetworkStatus status;
  final DashboardModel? dashboardModel;
  final bool isSwitched;

  const HomeState({this.status = NetworkStatus.initial,this.settings,this.dashboardModel,this.isSwitched = false});

  HomeState copy({BuildContext? context, Settings? settings, DashboardModel? dashboardModel,NetworkStatus? status,bool? isSwitched}) {
    return HomeState(settings: settings ?? this.settings,status: status ?? this.status,dashboardModel: dashboardModel ?? this.dashboardModel,isSwitched: isSwitched ?? this.isSwitched);
  }

  @override
  List<Object?> get props => [settings,dashboardModel,status,isSwitched];
}
