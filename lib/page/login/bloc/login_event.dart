part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable{

  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginPhoneChange extends LoginEvent{

   final String phone;

   const LoginPhoneChange({required this.phone});

   @override
   List<Object?> get props => [phone];
}

class LoginPasswordChange extends LoginEvent{

  final String password;

  const LoginPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginSubmit extends LoginEvent{
  const LoginSubmit();
}