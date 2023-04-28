import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
  late StreamSubscription<LoginData> _loginDataSubscription;

  AuthenticationBloc({required AuthenticationRepository authenticationRepository,required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository, _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {

    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequest);

    _authenticationStatusSubscription = _authenticationRepository.status.listen((status) => add(AuthenticationStatusChanged(status)));

    _loginDataSubscription = _authenticationRepository.loginData.listen((userData) => add(AuthenticationUserChanged(userData)));

  }

  _onAuthenticationStatusChanged(AuthenticationStatusChanged event,Emitter<AuthenticationState> emit) async {
    switch(event.status){
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  _onAuthenticationUserChanged(AuthenticationUserChanged event,Emitter<AuthenticationState> emit) async {
    debugPrint('event.data.toJson()${event.data.toJson()}');
    return emit(AuthenticationState.authenticated(event.data));
  }

  _onAuthenticationLogoutRequest(AuthenticationLogoutRequest event,Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.unauthenticated());
  }

  Future<void> onClose()async {
    _authenticationStatusSubscription.cancel();
    _loginDataSubscription.cancel();
    _authenticationRepository.dispose();
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {

    final status = json['status'];
    final userJson = json['user'];

    if(status == AuthenticationStatus.authenticated.name && userJson != null) {
      final user = LoginData.fromJson(userJson);
      _authenticationRepository.updateAuthenticationStatus(AuthenticationStatus.authenticated);
      _authenticationRepository.updateUserData(user);
      if(user.user != null) {
        return AuthenticationState.authenticated(user);
        _userRepository.tokenVerification(token: user.user?.token ?? '').then((isVerified) {
          if(isVerified){
            return AuthenticationState.authenticated(user);
          }
          _authenticationRepository.updateAuthenticationStatus(AuthenticationStatus.unauthenticated);
          _authenticationRepository.updateUserData(LoginData(user:  null));
          return const AuthenticationState.unauthenticated();
        });
      }
    }
    return const AuthenticationState.unauthenticated();
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    return <String,dynamic>{'status' : state.status.name,'user':state.data?.toJson()};
  }

}
