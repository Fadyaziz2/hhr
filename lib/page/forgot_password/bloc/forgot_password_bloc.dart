import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'forgot_password_state.dart';
part 'forgot_password_event.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final MetaClubApiClient metaClubApiClient;

  ForgotPasswordBloc({required this.metaClubApiClient})
      : super(const ForgotPasswordState(status: NetworkStatus.initial)) {
    on<GetVerificationCode>(_onVerificationCode);
    on<ForgotPassword>(_onForgotPassword);
  }

  FutureOr<void> _onVerificationCode(
      GetVerificationCode event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      var response = metaClubApiClient.getVerificationCode(email: event.email);
      if (response == true) {
        print('success');
      }
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onForgotPassword(
      ForgotPassword event, Emitter<ForgotPasswordState> emit) {
    try {
      emit(state.copyWith(status: NetworkStatus.loading));
      metaClubApiClient
          .forgetPassword(forgotPasswordBody: event.forgotPasswordBody)
          .then((expenseResponse) {
        Fluttertoast.showToast(msg: expenseResponse.toString());
        Navigator.pop(event.context);
      });
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
