import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';

import '../../../res/date_utils.dart';
import '../../../res/enum.dart';
import '../../../res/widgets/month_picker_dialog/month_picker_dialog.dart';

class DailyLeaveBloc extends Bloc<DailyLeaveEvent, DailyLeaveState> {
  final MetaClubApiClient _metaClubApiClient;

  DailyLeaveBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const DailyLeaveState(status: NetworkStatus.initial)) {
    on<DailyLeaveSummary>(_dailyLeaveSummary);
    on<SelectDatePickerDailyLeave>(_onSelectDatePicker);
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePickerDailyLeave event, Emitter<DailyLeaveState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(DailyLeaveSummary(event.userId));
    emit(state.copyWith(
        status: NetworkStatus.success, currentMonth: currentMonth));
  }

  FutureOr<void> _dailyLeaveSummary(
      DailyLeaveSummary event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      DailyLeaveSummaryModel? dailyLeaveSummaryModel =
          await _metaClubApiClient.dailyLeaveSummary(event.userId,
              state.currentMonth ?? DateFormat('y-MM').format(DateTime.now()));
      emit(state.copyWith(
          dailyLeaveSummaryModel: dailyLeaveSummaryModel,
          status: NetworkStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }
}
