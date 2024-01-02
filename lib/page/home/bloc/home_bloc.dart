import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appoinment_list/view/appointment_screen.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/home/view/home_mars/home_mars_page.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/content_neptune.dart';
import 'package:onesthrm/page/meeting/meeting.dart';
import 'package:onesthrm/page/visit/view/visit_page.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/service/notification_service.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';
import '../../../res/enum.dart';
import '../../app/global_state.dart';
import '../../support/view/support_page.dart';
import '../view/content/home_earth_content.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final MetaClubApiClient _metaClubApiClient;
  late StreamSubscription locationSubscription;

  HomeBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const HomeState()) {
    on<LoadSettings>(_onSettingsLoad);
    on<LoadHomeData>(_onHomeDataLoad);
    on<OnSwitchPressed>(_onSwitchPressed);
    on<OnLocationEnabled>(_onLocationEnabled);
    on<OnLocationRefresh>(_onLocationRefresh);
  }

  MetaClubApiClient get metaClubApiClient => _metaClubApiClient;

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    try {
      Settings? settings = await _metaClubApiClient.getSettings();
      globalState.set(dashboardStyleId, settings?.data?.appTheme);
      globalState.set(isLocation, settings?.data?.locationService);
      globalState.set(
          notificationChannels, settings?.data?.notificationChannels);
      await subscribeTopic();
      emit(state.copy(settings: settings, status: NetworkStatus.success));
    } catch (e) {
      emit(state.copy(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future subscribeTopic() async {
    final notifications = globalState.get(notificationChannels);
    if (notifications != null) {
      for (var topic in notifications) {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        debugPrint("Firebase topics: $topic");
      }
    }
  }

  void _onHomeDataLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
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
      globalState.set(
          isLocation, dashboardModel?.data?.config?.locationService);

      ///Initialize custom timer data [HOUR, MIN, SEC]
      globalState.set(hour,
          '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.hour ?? '0'}');
      globalState.set(min,
          '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.min ?? '0'}');
      globalState.set(sec,
          '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.sec ?? '0'}');
      final bool isLocationEnabled = globalState.get(isLocation);
      emit(state.copy(
          dashboardModel: dashboardModel,
          status: NetworkStatus.success,
          isSwitched: isLocationEnabled));
      await checkInScheduleNotification(
          dashboardModel?.data?.config?.dutySchedule?.listOfStartDatetime);
      await checkOutScheduleNotification(
          dashboardModel?.data?.config?.dutySchedule?.listOfEndDatetime);
    } catch (e) {
      emit(state.copy(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future checkInScheduleNotification(startTime) async {
    var listOfDates = [
      "2023-12-29 14:05",
      "2023-12-30 14:06",
      "2023-12-29 14:07",
    ];

    for (var dateString in startTime) {
      var splitMinute = dateString.split(" ")[1].split(":");
      DateTime dateTime = splitMinute.contains("00") ? DateTime.parse(dateString + "") : DateTime.parse(dateString + "0");
      if (dateTime.isBefore(DateTime.now()) && dateTime.day != DateTime.now().day) {
        await notificationPlugin.unSubscribeScheduleNotification(dateTime.day + dateTime.hour);
      } else {
        // Extract date and time components
        int day = dateTime.day;
        int hour = dateTime.hour;
        int minute = dateTime.minute;

        // Schedule the notification
        await notificationPlugin.scheduleNotification(
          id: day + hour,
          title: "Check In Alert",
          body: "Good morning have you checked in office yet",
          day: day,
          hour: hour,
          minute: minute,
          second: 0,
        );
      }
    }
  }

  Future checkOutScheduleNotification(outTime) async {
    for (var dateString in outTime) {
      // Parse the date-time string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString + "0");

      // Extract date and time components
      int day = dateTime.day;
      int hour = dateTime.hour;
      int minute = dateTime.minute;

      // Schedule the notification
      await notificationPlugin.scheduleNotification(
        id: day + hour,
        title: "Check Out Alert",
        body: "Good evening, have you checked out office yet",
        day: day,
        hour: hour,
        minute: minute,
        second: 0,
      );
    }
  }

/*var listOfDates = [
      "2023-12-29 12:21",
      "2023-12-29 12:21",
      "2023-12-29 12:21",
    ];
    for (var element in minLIst) {
      await notificationPlugin.scheduleNotification(
          id: null,
          title: "hello bijoy",
          body: "Good Morning $element",
          day: null,
          hour: null,
          minute: null,
          second: null);
    }*/

  void _onLocationRefresh(OnLocationRefresh event, Emitter<HomeState> emit) {
    emit(state.copy(isSwitched: true));
    if (event.user != null) {
      add(OnLocationEnabled(
          user: event.user!, locationProvider: event.locationProvider));
    }
  }

  void _onSwitchPressed(OnSwitchPressed event, Emitter<HomeState> emit) {
    emit(state.copy(isSwitched: !state.isSwitched));
    if (event.user != null) {
      add(OnLocationEnabled(
          user: event.user!, locationProvider: event.locationProvider));
    }
  }

  void _onLocationEnabled(OnLocationEnabled event, Emitter<HomeState> emit) {
    if (state.isSwitched) {
      event.locationProvider.getCurrentLocationStream(
          uid: event.user.id!, metaClubApiClient: _metaClubApiClient);
    } else {
      try {
        event.locationProvider.locationSubscription.pause();
      } catch (_) {}
    }
  }

  Widget chooseTheme() {
    final name = globalState.get(dashboardStyleId);
    switch (name) {
      case 'earth':
        return const HomeEarthContent();
      case 'neptune':
        return const HomeNeptuneContent();
      case 'mars':
        return const HomeMars();
      default:
        return const HomeContentShimmer();
    }
  }

  void routeSlug(slugName, context) {
    switch (slugName) {
      case 'support':
        NavUtil.navigateScreen(context, const SupportPage());
        break;
      case 'support_ticket':
        NavUtil.navigateScreen(context, const SupportPage());
        break;
      case 'visit':
        NavUtil.navigateScreen(context, const VisitPage());
        break;
      case 'appointment':
        NavUtil.navigateScreen(context, const AppointmentScreen());
        break;
      case 'meeting':
        NavUtil.navigateScreen(context, const MeetingPage());
        break;
      default:
        return debugPrint('default');
    }
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toJson();
  }
}
