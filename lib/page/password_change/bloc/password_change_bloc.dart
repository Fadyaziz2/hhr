import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/res/enum.dart';

part 'password_change_event.dart';
part 'password_change_state.dart';

class PasswordChangeBloc extends Bloc<PasswordChangeEvent, PasswordChangeState> {
  final MetaClubApiClient metaClubApiClient;

  PasswordChangeBloc({required this.metaClubApiClient})
      : super(const PasswordChangeState(status: NetworkStatus.initial)) {
    on<PasswordChange>(_onForgotPassword);
  }

  FutureOr<void> _onForgotPassword(PasswordChange event, Emitter<PasswordChangeState> emit) async {
    try {
      emit(state.copyWith(status: NetworkStatus.loading));
      VerificationCodeModel? response = await metaClubApiClient.updatePassword(passwordChangeBody: event.passwordChangeBody);
      if (response.result == true) {
        Fluttertoast.showToast(msg: response.message.toString());
        // ignore: use_build_context_synchronously
        BlocProvider.of<AuthenticationBloc>(event.context).add(AuthenticationLogoutRequest());
        // ignore: use_build_context_synchronously
        Navigator.of(event.context).pop();
        emit(state.copyWith(status: NetworkStatus.success));
      } else {
        Fluttertoast.showToast(msg: response.message.toString());
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
