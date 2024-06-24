import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/home/notification/schedule_notification.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/enum.dart';

part 'home_event.dart';
part 'home_state.dart';

typedef HomeBlocFactory = HomeBloc Function();

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final LogoutUseCase logoutUseCase;
  final HomeDatLoadUseCase homeDatLoadUseCase;
  final SettingsDataLoadUseCase settingsDataLoadUseCase;
  final EventBus eventBus;

  HomeBloc({required this.logoutUseCase, required this.homeDatLoadUseCase, required this.settingsDataLoadUseCase,required this.eventBus})
      : super(const HomeState()) {
    ///Assign the appTheme at init contractor so that
    ///view can load more first(data from last state)
    globalState.set(dashboardStyleId, state.settings?.data?.appTheme);

    ///-----------------------------------------------------------///
    on<LoadSettings>(_onSettingsLoad);
    on<LoadHomeData>(_onHomeDataLoad);
    on<OnSwitchPressed>(_onSwitchPressed);
    on<OnLocationEnabled>(_onLocationEnabled);
    on<OnLocationRefresh>(_onLocationRefresh);

    Timer.periodic(const Duration(minutes: 2), (_) {
      /// we have try store data to server from local cache
      _onOfflineDataSync();
    });

    eventBus.on<OfflineDataSycEvent>().listen((data) {
      /// we have try store data to server from local cache
      _onOfflineDataSync();
    });
  }

  bool isCheckedIn = false;
  bool isCheckedOut = false;

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {
    if (state.settings == null && state.dashboardModel == null) {
      emit(state.copy(status: NetworkStatus.loading));
    }
    final data = await settingsDataLoadUseCase();
    data.fold((l) {
      if (l.failureType == FailureType.httpStatus) {
        if ((l as GeneralFailure).httpStatusCode == 401) {
          logoutUseCase();
        }
      }
      emit(state.copy(status: NetworkStatus.failure));
    }, (settings) {
      globalState.set(dashboardStyleId, settings?.data?.appTheme);
      globalState.set(isLocation, settings?.data?.locationService);
      globalState.set(notificationChannels, settings?.data?.notificationChannels);

      ///Assign default shift in pref
      if (settings != null) {
        if (settings.data!.shifts.isNotEmpty) {
          SharedUtil.setIntValue(shiftId, settings.data?.shifts.first.shiftId);
        }
      }
      subscribeTopic();
      emit(state.copy(settings: settings, status: NetworkStatus.success));
    });
  }

  Future subscribeTopic() async {
    final notifications = globalState.get(notificationChannels);

    try {
      ///channel wise notification setup
      FirebaseMessaging.instance.subscribeToTopic('onesthrm');
      if (notifications != null) {
        for (var topic in notifications) {
          await FirebaseMessaging.instance.subscribeToTopic(topic);
          debugPrint("Firebase topics: $topic");
        }
      }
    } catch (_) {
      return;
    }
  }

  void _onHomeDataLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    if (state.settings == null && state.dashboardModel == null) {
      emit(state.copy(status: NetworkStatus.loading));
    }

    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    isCheckedIn = attendanceService.isAlreadyInCheckedIn(date: date);
    isCheckedOut = attendanceService.isAlreadyInCheckedOut(date: date);
    final localAttendanceData = attendanceService.getCheckDataByDate(date: date);

    final data = await homeDatLoadUseCase();
    data.fold((l) {
      if (l.failureType == FailureType.httpStatus) {
        if ((l as GeneralFailure).httpStatusCode == 401) {
          logoutUseCase();
        }
      }
      emit(state.copy(status: NetworkStatus.failure));
    }, (r) {
      AttendanceData? attendanceData = r?.data?.attendanceData;

      ///Schedule check-in notification
      checkInScheduleNotification(r?.data?.config?.dutySchedule?.listOfStartDatetime ?? [],
          r?.data?.config?.dutySchedule?.listOfEndDatetime ?? []);

      ///Initialize attendance data into global state
      globalState.set(attendanceId, attendanceData?.id);
      globalState.set(inTime, r?.data?.attendanceData?.inTime);
      globalState.set(outTime, r?.data?.attendanceData?.outTime);
      globalState.set(stayTime, r?.data?.attendanceData?.stayTime);

      ///Initialize break data into global state
      globalState.set(breakTime, r?.data?.config?.breakStatus?.breakTime);
      globalState.set(backTime, r?.data?.config?.breakStatus?.backTime);
      globalState.set(breakStatus, r?.data?.config?.breakStatus?.status);
      globalState.set(isLocation, r?.data?.config?.locationService);

      ///Initialize custom timer data [HOUR, MIN, SEC]
      globalState.set(hour, '${r?.data?.config?.breakStatus?.timeBreak?.hour ?? '0'}');
      globalState.set(min, '${r?.data?.config?.breakStatus?.timeBreak?.min ?? '0'}');
      globalState.set(sec, '${r?.data?.config?.breakStatus?.timeBreak?.sec ?? '0'}');

      final bool isLocationEnabled = globalState.get(isLocation);

      _onOfflineDataSync();

      emit(state.copy(dashboardModel: r, status: NetworkStatus.success, isSwitched: isLocationEnabled));
    });

    ///today's data available in local so we need to update in/out time from there
    if (localAttendanceData != null) {
      globalState.set(inTime, localAttendanceData.inTime);
      globalState.set(outTime, localAttendanceData.outTime);
    }
  }

  void _onOfflineDataSync() async {
    final today = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    isCheckedOut = attendanceService.isAlreadyInCheckedOut(date: today);
    late Map<String, dynamic> body;
    if (isCheckedOut) {
      body = attendanceService.getAllCheckInOutDataMap();
    } else {
      body = attendanceService.getPastCheckInOutDataMap(today: today);
    }
    if (body['data'].isNotEmpty) {
      final isSynced = await instance<MetaClubApiClient>().offlineCheckInOut(body: body);
      isSynced.fold((l) {}, (r) {
        if (r) {
          if (isCheckedOut) {
            attendanceService.clearCheckOfflineData();
          } else {
            attendanceService.deleteFilteredCheckInOut(today: today);
          }
        }
      });
    }
  }

  void _onLocationRefresh(OnLocationRefresh event, Emitter<HomeState> emit) {
    emit(state.copy(isSwitched: true));
    if (event.user != null) {
      add(OnLocationEnabled(user: event.user!, locationProvider: event.locationProvider));
    }
  }

  void _onSwitchPressed(OnSwitchPressed event, Emitter<HomeState> emit) {
    emit(state.copy(isSwitched: !state.isSwitched));
    if (event.user != null) {
      add(OnLocationEnabled(user: event.user!, locationProvider: event.locationProvider));
    }
  }

  void _onLocationEnabled(OnLocationEnabled event, Emitter<HomeState> emit) {
    if (state.isSwitched) {
      event.locationProvider.getCurrentLocationStream(
          uid: '${globalState.get(companyId)}${event.user.id!}', metaClubApiClient: instance());
    } else {
      try {
        event.locationProvider.locationSubscription.pause();
      } catch (_) {}
    }
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    SharedUtil.getBoolValue(isTokenVerified).then((isTokenVerified) {
      return HomeState.fromJson(json, isTokenVerified);
    });
    return HomeState.fromJson(json, true);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toJson();
  }
}
