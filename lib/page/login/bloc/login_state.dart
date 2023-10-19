part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isValid;
  final LoginFailure? message;
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final LoginData? user;

  const LoginState({this.isValid = false,
      this.status = FormzSubmissionStatus.initial,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.message,
      this.user});

  LoginState copyWith(
      { FormzSubmissionStatus? status,bool? isValid, Email? email, Password? password, LoginData? user,LoginFailure? message}) {
    return LoginState(
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        message: message ?? this.message,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, email, password,user,message];
}
