import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/password.dart';
import '../models/phone.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {

  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()){
   on<LoginEmailChange>(_onPhoneUpdate);
   on<LoginPasswordChange>(_onPasswordUpdate);
   on<LoginSubmit>(_onLoginSubmitted);
  }

  void _onPhoneUpdate(LoginEmailChange event,Emitter<LoginState> emit){

    final phone = Email.dirty(event.email);

    emit(state.copyWith(phone: phone,status: Formz.validate([phone,state.password])));
  }

  void _onPasswordUpdate(LoginPasswordChange event,Emitter<LoginState> emit){

    final password = Password.dirty(event.password);

    emit(state.copyWith(password: password,status: Formz.validate([state.email,password])));
  }

  void _onLoginSubmitted(LoginSubmit event,Emitter<LoginState> emit) async {

    if(state.status.isValidated){

      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try{

        final user = await _authenticationRepository.login(email: state.email.value, password: state.password.value);

        if(user == null){
          emit(state.copyWith(status: FormzStatus.submissionFailure,user: user));
        }else{
          emit(state.copyWith(status: FormzStatus.submissionSuccess,user: user));
        }
      }catch(_){
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {

    final data = json['data'];

    if(data != null) {
      final userData = LoginData.fromJson(data);
      return LoginState(user: userData,status: FormzStatus.submissionSuccess);
    } else {
      return const LoginState(user: null,status: FormzStatus.submissionFailure);
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return <String,dynamic>{'data' : state.user != null ? state.user!.toJson():null};
  }
}
