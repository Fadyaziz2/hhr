import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/view/home_mars/home_mars_page.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/content_neptune.dart';
import '../../../res/const.dart';
import '../../../res/enum.dart';
import '../../app/global_state.dart';
import '../view/content/home_earth_content.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MetaClubApiClient _metaClubApiClient;

  HomeBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const HomeState(status: NetworkStatus.initial)) {
    on<LoadSettings>(_onSettingsLoad);
    on<LoadHomeData>(_onHomeDataLoad);
  }

  MetaClubApiClient get metaClubApiClient => _metaClubApiClient;

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {
    emit(const HomeState(status: NetworkStatus.loading));
    try {
      Settings? settings = await _metaClubApiClient.getSettings();
      globalState.set(dashboardStyleId, settings?.data?.appTheme);
      emit(state.copy(settings: settings, status: NetworkStatus.success));
    } catch (e) {
      emit(const HomeState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  void _onHomeDataLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeState(status: NetworkStatus.loading));
    try {
      DashboardModel? dashboardModel =
          await _metaClubApiClient.getDashboardData();

      ///Initialize attendance data at global state
      globalState.set(attendanceId, dashboardModel?.data?.attendanceData?.id);
      globalState.set(inTime, dashboardModel?.data?.attendanceData?.inTime);
      globalState.set(outTime, dashboardModel?.data?.attendanceData?.outTime);
      globalState.set(stayTime, dashboardModel?.data?.attendanceData?.stayTime);
      globalState.set(
          breakTime, dashboardModel?.data?.config?.breakStatus?.breakTime);
      globalState.set(
          backTime, dashboardModel?.data?.config?.breakStatus?.backTime);
      globalState.set(
          breakStatus, dashboardModel?.data?.config?.breakStatus?.status);

      ///Initialize custom timer data [HOUR, MIN, SEC]
      globalState.set(hour,
          '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.hour ?? '0'}');
      globalState.set(min,
          '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.min ?? '0'}');
      globalState.set(sec,
          '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.sec ?? '0'}');
      emit(state.copy(
          dashboardModel: dashboardModel, status: NetworkStatus.success));
    } catch (e) {
      emit(const HomeState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  Widget chooseTheme() {
    final id = globalState.get(dashboardStyleId);
    print("appTheme $id");
    switch (id) {
      case 1:
        return const HomeEarthContent();
      case 2:
        return const HomeMars();
      default:
        return const HomeNeptuneContent();
    }
  }
}
