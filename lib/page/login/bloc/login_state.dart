part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final LoginData? user;

  const LoginState({this.status = FormzSubmissionStatus.initial,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.user});

  LoginState copyWith(
      {FormzSubmissionStatus? status, Email? phone, Password? password, LoginData? user}) {
    return LoginState(
        status: status ?? this.status,
        email: phone ?? email,
        password: password ?? this.password,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, email, password,user];
}
