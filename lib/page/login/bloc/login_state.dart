part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Phone phone;
  final Password password;
  final LoginData? user;

  const LoginState(
      {this.status = FormzStatus.pure,
      this.phone = const Phone.pure(),
      this.password = const Password.pure(),
      this.user});

  LoginState copyWith(
      {FormzStatus? status, Phone? phone, Password? password, LoginData? user}) {
    return LoginState(
        status: status ?? this.status,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, phone, password,user];
}
