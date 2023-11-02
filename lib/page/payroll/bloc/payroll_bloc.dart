import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payroll_event.dart';

part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final MetaClubApiClient metaClubApiClient;

  PayrollBloc({required this.metaClubApiClient}) : super(const PayrollState(status: NetworkStatus.initial)) {
    on<PayrollInitialDataRequest>(_onPayrollDataInitialDataRequest);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onPayrollDataInitialDataRequest(PayrollInitialDataRequest event, Emitter<PayrollState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());
    try {
      final payrollData = await metaClubApiClient.getPayrollData(year: event.setDate ?? currentDate);
      emit(state.copyWith(status: NetworkStatus.success, payroll: payrollData, isLoading: false));
    } on Exception catch (e) {
      emit(const PayrollState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  getPaySlip(String link) async {
    launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication).onError(
      (error, stackTrace) {
        debugPrint("Url is not valid!");
        return false;
      },
    );
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<PayrollState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(PayrollInitialDataRequest(setDate: currentMonth));
  }
}
