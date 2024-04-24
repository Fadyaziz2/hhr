import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/appointment/appoinment_list/view/appointment_screen.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/home/view/home_mars/home_mars_page.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/content_neptune.dart';
import 'package:onesthrm/page/meeting/meeting.dart';
import 'package:onesthrm/page/visit/view/visit_page.dart';
import 'package:onesthrm/res/event_bus/offline_data_sync_event.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/service/notification_service.dart';
import 'package:onesthrm/res/shared_preferences.dart';
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
  final AttendanceService _attendanceService;
  late StreamSubscription locationSubscription;
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  HomeBloc({
    required MetaClubApiClient metaClubApiClient,
    required AttendanceService attendanceService,
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository
  })  : _metaClubApiClient = metaClubApiClient,
        _attendanceService = attendanceService,
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const HomeState()) {
    ///Assign the appTheme at init contractor so that
    ///view can load more first(data from last state)
    globalState.set(dashboardStyleId, state.settings?.data?.appTheme);

    ///-----------------------------------------------------------///
    on<LoadSettings>(_onSettingsLoad);
    on<LoadHomeData>(_onHomeDataLoad);
    on<OnSwitchPressed>(_onSwitchPressed);
    on<OnLocationEnabled>(_onLocationEnabled);
    on<OnLocationRefresh>(_onLocationRefresh);
    on<OnTokenVerification>(_checkTokenValidity);

    Timer.periodic(const Duration(minutes: 2), (_) {
      /// we have try store data to server from local cache
      _onOfflineDataSync();
    });

    eventBus.on<OfflineDataSycEvent>().listen((data) {
      /// we have try store data to server from local cache
      _onOfflineDataSync();
    });

    ///check token validity event
   add(OnTokenVerification());
  }

  bool isCheckedIn = false;
  bool isCheckedOut = false;

  MetaClubApiClient get metaClubApiClient => _metaClubApiClient;

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {
    if (state.settings == null && state.dashboardModel == null) {
      emit(state.copy(status: NetworkStatus.loading));
    }
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

    ///channel wise notification setup
    FirebaseMessaging.instance.subscribeToTopic('onesthrm');
    if (notifications != null) {
      for (var topic in notifications) {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        debugPrint("Firebase topics: $topic");
      }
    }
  }

  void _onHomeDataLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    if (state.settings == null && state.dashboardModel == null) {
      emit(state.copy(status: NetworkStatus.loading));
    }

    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    isCheckedIn = _attendanceService.isAlreadyInCheckedIn(date: date);
    isCheckedOut = _attendanceService.isAlreadyInCheckedOut(date: date);
    final localAttendanceData =
        _attendanceService.getCheckDataByDate(date: date);

    try {
      DashboardModel? dashboardModel =
          await _metaClubApiClient.getDashboardData();
      AttendanceData? attendanceData = dashboardModel?.data?.attendanceData;

      ///Schedule check-in notification
      checkInScheduleNotification(
          dashboardModel?.data?.config?.dutySchedule?.listOfStartDatetime ?? [],
          dashboardModel?.data?.config?.dutySchedule?.listOfEndDatetime ?? []);

      ///Initialize attendance data into global state
      globalState.set(attendanceId, attendanceData?.id);
      globalState.set(inTime, dashboardModel?.data?.attendanceData?.inTime);
      globalState.set(outTime, dashboardModel?.data?.attendanceData?.outTime);
      globalState.set(stayTime, dashboardModel?.data?.attendanceData?.stayTime);

      ///Initialize break data into global state
      globalState.set(
          breakTime, dashboardModel?.data?.config?.breakStatus?.breakTime);
      globalState.set(
          backTime, dashboardModel?.data?.config?.breakStatus?.backTime);
      globalState.set(
          breakStatus, dashboardModel?.data?.config?.breakStatus?.status);
      globalState.set(
          isLocation, dashboardModel?.data?.config?.locationService);

      ///Initialize custom timer data [HOUR, MIN, SEC]
      globalState.set(hour, '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.hour ?? '0'}');
      globalState.set(min, '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.min ?? '0'}');
      globalState.set(sec, '${dashboardModel?.data?.config?.breakStatus?.timeBreak?.sec ?? '0'}');

      final bool isLocationEnabled = globalState.get(isLocation);

      _onOfflineDataSync();

      emit(state.copy(
          dashboardModel: dashboardModel,
          status: NetworkStatus.success,
          isSwitched: isLocationEnabled));
    } catch (e) {
      emit(state.copy(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }

    ///today's data available in local so we need to update in/out time from there
    if (localAttendanceData != null) {
      globalState.set(inTime, localAttendanceData.inTime);
      globalState.set(outTime, localAttendanceData.outTime);
    }
  }

  void _checkTokenValidity(OnTokenVerification event, Emitter<HomeState> emit) async {
    ///verify token
    final data = await _userRepository.tokenVerification(token: metaClubApiClient.token,baseUrl: metaClubApiClient.companyUrl);
    if(data.status == false || data.code >= 400){
      _authenticationRepository.updateAuthenticationStatus(AuthenticationStatus.unauthenticated);
      _authenticationRepository.updateUserData(LoginData(user:  null));
      SharedUtil.setBoolValue(isTokenVerified, false);
      emit(state.copy(isTokenVerified: false));
    }
    emit(state.copy(isTokenVerified: true));
  }

  void _onOfflineDataSync() async {
    try {
      final today = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
      late Map<String, dynamic> body;
      if (isCheckedOut) {
        body = attendanceService.getAllCheckInOutDataMap();
      } else {
        body = attendanceService.getPastCheckInOutDataMap(today: today);
      }
      if (body['data'].isNotEmpty) {
          final isSynced = await _metaClubApiClient.offlineCheckInOut(body: body);
          if (isSynced) {
            if (isCheckedOut) {
              attendanceService.clearCheckOfflineData();
            }else{
              attendanceService.deleteFilteredCheckInOut(today: today);
            }
          }
      }
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future checkInScheduleNotification(List<CheckTime> startTime, List<CheckTime> endTime) async {
    ///unsubscribe * previous subscription if any
    await notificationPlugin.unSubscribeScheduleAll();
    final formatter = DateFormat('yyyy-MM-dd hh:mm');

    /// Schedule the notification
    ///looping all schedule and set that schedule as active
    for (var inTime in startTime) {
      DateTime dateTime = formatter.parse(inTime.date);

      /// Extract date and time components
      int day = dateTime.day;
      int year = dateTime.year;
      int month = dateTime.month;
      int hour = dateTime.hour;
      int minute = dateTime.minute;

      /// Schedule the notification
      await notificationPlugin.scheduleNotification(
        id: inTime.id,
        title: "Check In Alert",
        body: "Good morning have you checked in office yet from onesttech",
        day: day,
        year: year,
        month: month,
        hour: hour,
        minute: minute,
        second: 0,
      );
    }
    for (var outTime in endTime) {
      DateTime dateTime = formatter.parse(outTime.date);

      /// Extract date and time components
      int day = dateTime.day;
      int hour = dateTime.hour;
      int minute = dateTime.minute;
      int year = dateTime.year;
      int month = dateTime.month;

      /// Schedule the notification
      await notificationPlugin.scheduleNotification(
        id: outTime.id,
        title: "Check Out Alert",
        body: "Good evening, have you checked out office yet from onesttech",
        day: day,
        year: year,
        month: month,
        hour: hour,
        minute: minute,
        second: 0,
      );
    }
  }

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
    SharedUtil.getBoolValue(isTokenVerified).then((isTokenVerified){
      return HomeState.fromJson(json,isTokenVerified);
    });
    return HomeState.fromJson(json,true);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toJson();
  }
}
