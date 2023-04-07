import 'package:club_application/page/login/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {

  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()){
   on<LoginPhoneChange>(_onPhoneUpdate);
   on<LoginPasswordChange>(_onPasswordUpdate);
   on<LoginSubmit>(_onLoginSubmitted);
  }

  void _onPhoneUpdate(LoginPhoneChange event,Emitter<LoginState> emit){

    final phone = Phone.dirty(event.phone);

    emit(state.copyWith(phone: phone,status: Formz.validate([phone,state.password])));
  }

  void _onPasswordUpdate(LoginPasswordChange event,Emitter<LoginState> emit){

    final password = Password.dirty(event.password);

    emit(state.copyWith(password: password,status: Formz.validate([state.phone,password])));
  }

  void _onLoginSubmitted(LoginSubmit event,Emitter<LoginState> emit) async {

    if(state.status.isValidated){

      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try{

        final user = await _authenticationRepository.login(phone: state.phone.value, password: state.password.value);

        debugPrint('object ${user?.token}');

        if(user == null){
          emit(state.copyWith(status: FormzStatus.submissionFailure,user: user));
        }else{
          if(user.user?.isActive  == 0 && user.user?.isVerified  == 0){
            emit(state.copyWith(status: FormzStatus.submissionCanceled,user: user));
          }else{
            emit(state.copyWith(status: FormzStatus.submissionSuccess,user: user));
          }
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
