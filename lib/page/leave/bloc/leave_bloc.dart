import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/view/leave_page.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';
part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final MetaClubApiClient _metaClubApiClient;
  var dateTime = DateTime.now();

  LeaveBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const LeaveState(status: NetworkStatus.initial)) {
    on<LeaveSummaryApi>(_leaveSummaryApi);
    on<LeaveRequest>(_leaveRequest);
    on<LeaveRequestTypeEven>(_leaveRequestTypeApi);
    on<SelectedRequestType>(_selectedRequestType);
    on<SelectedCalendar>(_selectedCalendar);
    on<SelectEmployee>(_selectEmployee);
    on<SubmitLeaveRequest>(_submitLeaveRequest);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<LeaveState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: dateTime,
      locale: const Locale("en"),
    );

    dateTime = date!;
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(LeaveRequest(event.context, currentMonth));
    emit(state.copyWith(
        status: NetworkStatus.success, currentMonth: currentMonth));
  }

  FutureOr<void> _submitLeaveRequest(
      SubmitLeaveRequest? event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .submitLeaveRequestApi(
              bodyCreateLeaveModel: event?.bodyCreateLeaveModel)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Leave Request create successfully");
          add(LeaveRequest(
              event!.context, DateFormat('y-MM').format(DateTime.now())));
          NavUtil.replaceScreen(event.context, const LeavePage());
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _leaveRequestTypeApi(
      LeaveRequestTypeEven? event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final user = event?.context.read<AuthenticationBloc>().state.data;
      LeaveRequestTypeModel? leaveRequestTypeResponse =
          await _metaClubApiClient.leaveRequestTypeApi(user?.user?.id);

      emit(state.copyWith(
          leaveRequestType: leaveRequestTypeResponse,
          status: NetworkStatus.success));

      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _leaveRequest(
      LeaveRequest event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final user = event.context.read<AuthenticationBloc>().state.data;
      LeaveRequestModel? leaveRequestResponse = await _metaClubApiClient
          .leaveRequestApi(user?.user?.id, event.pickedDate);

      emit(state.copyWith(
          leaveRequestModel: leaveRequestResponse,
          status: NetworkStatus.success));

      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _leaveSummaryApi(
      LeaveSummaryApi event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final user = event.context.read<AuthenticationBloc>().state.data;
      LeaveSummaryModel? leaveSummaryResponse =
          await _metaClubApiClient.leaveSummaryApi(user?.user?.id);

      emit(state.copyWith(
          leaveSummaryModel: leaveSummaryResponse,
          status: NetworkStatus.success));

      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _selectedRequestType(
      SelectedRequestType event, Emitter<LeaveState> emit) {
    emit(state.copyWith(selectedRequestType: event.availableLeaveType));
  }

  FutureOr<void> _selectedCalendar(
      SelectedCalendar event, Emitter<LeaveState> emit) {
    emit(state.copyWith(startDate: event.startDate, endDate: event.endDate));
  }

  FutureOr<void> _selectEmployee(
      SelectEmployee event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(selectedEmployee: event.selectEmployee));
  }
}
