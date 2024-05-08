import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import '../../../res/const.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final MetaClubApiClient _metaClubApiClient;
  final AttendanceService offlineAttendanceDB;
  final LocationServiceProvider _locationServices;
  final AttendanceType attendanceType;
  AttendanceBody body = AttendanceBody();
  final String? _selfie;
  late bool isCheckedIn;
  late bool isCheckedOut;

  AttendanceBloc({required MetaClubApiClient metaClubApiClient,
    required AttendanceService attendanceService,
    required LocationServiceProvider locationServices,
    required this.attendanceType,
    required InternetStatus internetStatus,
    String? selfie})
      : _metaClubApiClient = metaClubApiClient,
        offlineAttendanceDB = attendanceService,
        _locationServices = locationServices,
        _selfie = selfie,
        super(const AttendanceState(status: NetworkStatus.initial)) {

    body.date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    isCheckedIn = offlineAttendanceDB.isAlreadyInCheckedIn(date: body.date!);
    isCheckedOut = offlineAttendanceDB.isAlreadyInCheckedOut(date: body.date!);

    on<OnLocationInitEvent>(_onLocationInit);
    on<OnLocationRefreshEvent>(_onLocationRefresh);
    on<OnRemoteModeChanged>(_onRemoteModeUpdate);
    on<OnAttendance>(_onAttendance);
    on<OnOfflineAttendance>(_onOfflineAttendance);
    on<OnLocationUpdated>(_onLocationUpdated);
    on<ReasonEvent>(_onReason);

    SharedUtil.getIntValue(shiftId).then((sid) {
      body.shiftId = sid;
    });

    if (attendanceType == AttendanceType.qr || attendanceType == AttendanceType.face || attendanceType == AttendanceType.selfie) {
      ///for auto check in/out , we need to initialize location
      add(OnLocationInitEvent());

      ///----------------------------------------------------///
      ///if not normal attendance, this event call automatically
      add(OnAttendance());
      ///---------------///---------------------------------///
    }
  }

  void _onReason(ReasonEvent event, Emitter<AttendanceState> emit) async {
    body.reason = event.reasonData;
  }

  void _onLocationInit(OnLocationInitEvent event, Emitter<AttendanceState> emit) async {
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';

    ///Initialize attendance data at global state
    AttendanceData? attendanceData = event.dashboardModel?.data?.attendanceData;
    globalState.set(inTime, attendanceData?.inTime);
    globalState.set(outTime, attendanceData?.outTime);
    globalState.set(stayTime, attendanceData?.stayTime);

    add(OnLocationRefreshEvent());
  }

  void _onLocationUpdated(OnLocationUpdated event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(location: event.place, actionStatus: ActionStatus.location));
  }

  void _onLocationRefresh(OnLocationRefreshEvent event, Emitter<AttendanceState> emit) async {
    isCheckedIn = offlineAttendanceDB.isAlreadyInCheckedIn(date: body.date!);
    isCheckedOut = offlineAttendanceDB.isAlreadyInCheckedOut(date: body.date!);

    emit(state.copyWith(locationLoaded: false,
        actionStatus: ActionStatus.refresh,
        isCheckedIn: isCheckedIn,
        isCheckedOut: isCheckedOut));
    _locationServices.placeStream.listen((location) async {
      body.latitude = '${_locationServices.userLocation.latitude}';
      body.longitude = '${_locationServices.userLocation.longitude}';
      add(OnLocationUpdated(place: location));
    });
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(locationLoaded: true, actionStatus: ActionStatus.refresh));
  }

  void _onRemoteModeUpdate(OnRemoteModeChanged event, Emitter<AttendanceState> emit) {
    body.mode = event.mode;
    SharedUtil.setRemoteModeType(event.mode);
  }

  void _onAttendance(OnAttendance event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading, actionStatus: ActionStatus.checkInOut));
    body.mode ??= await SharedUtil.getRemoteModeType() ?? 0;
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';
    body.attendanceId = globalState.get(attendanceId);
    final checkInOutDataModel = body.toOnlineJson();

    final data = await _metaClubApiClient.checkInOut(body: checkInOutDataModel);

    data.fold((l) {
      ///------------------------Refresh data in OfflineAttendanceCubit-------------------------------------
      add(OnOfflineAttendance());
      ///----------------------------------*********--------------------------------------------------------
    }, (data) {
      body.isOffline = false;
      final inTime = getDDMMYYYYAsString(date: data?.checkInOut?.checkIn ?? '00:00:00 00:00',
          inputFormat: 'yyyy-mm-dd hh:mm',
          outputFormat: 'hh:mm aa');
      final outTime = getDDMMYYYYAsString(date: data?.checkInOut?.checkOut ?? '00:00:00 00:00',
          inputFormat: 'yyyy-mm-dd hh:mm',
          outputFormat: 'hh:mm aa');
      body.attendanceId = data?.checkInOut?.id;
      body.inTime = inTime;
      body.outTime = outTime;
      if (body.inTime != null && body.outTime != null) {
        body.attendanceId = null;
        globalState.set(attendanceId, null);
        attendanceService.clearCheckData();
      } else {
        globalState.set(attendanceId, data?.checkInOut?.checkOut == null ? data?.checkInOut?.id : null);
      }
      globalState.set(inTime, data?.checkInOut?.inTime);
      globalState.set(outTime, data?.checkInOut?.outTime);
      globalState.set(stayTime, data?.checkInOut?.stayTime);
      ///------------------------Refresh data in OfflineAttendanceCubit-------------------------------------
      eventBus.fire(OnOnlineAttendanceUpdateEvent(body: body));
      ///----------------------------------*********--------------------------------------------------------
      emit(state.copyWith(status: NetworkStatus.success, checkData: data,actionStatus: ActionStatus.checkInOut));
    });
  }

  void _onOfflineAttendance(OnOfflineAttendance event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading, actionStatus: ActionStatus.checkInOut));
    body.isOffline = true;
    body.mode ??= await SharedUtil.getRemoteModeType() ?? 0;
    body.attendanceId = globalState.get(attendanceId);
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';

    ///----------------------------------*********--------------------------------------------------------
    isCheckedIn = offlineAttendanceDB.isAlreadyInCheckedIn(date: body.date!);
    isCheckedOut = offlineAttendanceDB.isAlreadyInCheckedOut(date: body.date!);

    if (body.attendanceId != null) {
      add(OnAttendance());
    } else {
      ///------------------------Refresh data in OfflineAttendanceCubit-------------------------------------
      eventBus.fire(OnOfflineAttendanceUpdateEvent(body: body));

      ///----------------------------------*********--------------------------------------------------------
      final checkData = CheckData(message: '${(isCheckedIn == isCheckedOut || isCheckedIn == false)
          ? 'Check-In'
          : 'Check-Out'} successfully. CHEERS!!!',
          result: true,
          checkInOut: convertToCheckout(body: body, inStatus: isCheckedIn ? 'check-in' : 'check-out'));

      emit(state.copyWith(status: NetworkStatus.success, checkData: checkData));
    }
  }

  CheckInOut convertToCheckout({required AttendanceBody body, String? inStatus}) {
    final checkData = CheckInOut(
        id: 0,
        remoteMode: body.mode,
        date: body.date,
        inTime: body.inTime,
        outTime: body.outTime,
        latitude: body.latitude,
        longitude: body.longitude,
        inStatus: inStatus);
    return checkData;
  }
}
