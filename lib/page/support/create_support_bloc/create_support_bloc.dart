import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/create_support_bloc/create_support_state.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

import 'create_support_event.dart';

class CreateSupportBloc extends Bloc<CreateSupportEvent, CreateSupportState> {
  final MetaClubApiClient _metaClubApiClient;

  CreateSupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const CreateSupportState(status: NetworkStatus.initial)) {
    on<GetPriority>(_onGetPriority);
    on<SubmitButton>(onSubmitButton);
  }

  FutureOr<void> _onGetPriority(
      GetPriority event, Emitter<CreateSupportState> emit) {
    emit(state.copy(bodyPrioritySupport: event.bodyPrioritySupport));
  }

  FutureOr<void> onSubmitButton(
      SubmitButton event, Emitter<CreateSupportState> emit) async {
    emit(const CreateSupportState(status: NetworkStatus.loading));

    try {
      await _metaClubApiClient
          .createSupport(bodyCreateSupport: event.bodyCreateSupport)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Ticket created successfully");
          NavUtil.navigateScreen(event.context, const SupportPage());
        } else {
          emit(const CreateSupportState(status: NetworkStatus.failure));
        }
      });
    } catch (e) {
      emit(const CreateSupportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
