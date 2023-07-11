import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';
import '../../../res/enum.dart';
import '../../app/global_state.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final MetaClubApiClient _metaClubApiClient;

  HomeBloc({required MetaClubApiClient metaClubApiClient}): _metaClubApiClient = metaClubApiClient, super(const HomeState(status: NetworkStatus.initial)) {
    on<LoadSettings>(_onSettingsLoad);
    on<LoadHomeData>(_onHomeDataLoad);
  }

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {

    emit(const HomeState(status: NetworkStatus.loading));
    try {
      Settings? settings = await _metaClubApiClient.getSettings();

      emit(state.copy(settings: settings,status: NetworkStatus.success));
    } catch (e) {
      emit(const HomeState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  void _onHomeDataLoad(LoadHomeData event, Emitter<HomeState> emit) async {

    emit(const HomeState(status: NetworkStatus.loading));
    try {
      DashboardModel? dashboardModel = await _metaClubApiClient.getDashboardData();
      globalState.set(attendanceId, dashboardModel?.data?.attendanceData?.id);
      globalState.set(inTime, dashboardModel?.data?.attendanceData?.inTime);
      globalState.set(outTime, dashboardModel?.data?.attendanceData?.outTime);
      globalState.set(stayTime, dashboardModel?.data?.attendanceData?.stayTime);
      emit(state.copy(dashboardModel: dashboardModel,status: NetworkStatus.success));
    } catch (e) {
      emit(const HomeState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
