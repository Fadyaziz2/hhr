import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payroll_event.dart';

part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final MetaClubApiClient metaClubApiClient;

  PayrollBloc({required this.metaClubApiClient})
      : super(const PayrollState(status: NetworkStatus.initial)) {
    on<PayrollInitialDataRequest>(_onPayrollDataInitialDataRequest);
  }

  String formattedDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM');
    final String formatted = formatter.format(now);
    return formatted;
  }

  FutureOr<void> _onPayrollDataInitialDataRequest(
      PayrollInitialDataRequest event, Emitter<PayrollState> emit) async {
    final String year = formattedDateTime();
    try {
      final payrollData =
          await metaClubApiClient.getPayrollData(year: state.year ?? year);

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
}
