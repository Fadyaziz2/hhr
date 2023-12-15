import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'forgot_password_state.dart';
part 'forgot_password_event.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final MetaClubApiClient metaClubApiClient;

  ForgotPasswordBloc({required this.metaClubApiClient})
      : super(const ForgotPasswordState(status: NetworkStatus.initial)) {}
}
