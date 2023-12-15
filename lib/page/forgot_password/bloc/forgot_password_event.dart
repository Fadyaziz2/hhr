part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPassword extends ForgotPasswordEvent {
  final ForgotPasswordBody forgotPasswordBody;
  final BuildContext context;

  ForgotPassword(this.forgotPasswordBody, this.context);
  @override
  List<Object> get props => [forgotPasswordBody];
}
