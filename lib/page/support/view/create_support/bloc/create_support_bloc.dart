
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/view/create_support/bloc/create_support_state.dart';
import 'package:onesthrm/res/enum.dart';

import 'create_support_event.dart';

class CreateSupportBloc extends Bloc<CreateSupportEvent, CreateSupportState> {
  final MetaClubApiClient _metaClubApiClient;

  CreateSupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient, super(const CreateSupportState(status: NetworkStatus.initial)){

    on<GetPriority>(_onGetPriority);
    on<AddFile>(_onAddFile);
  }




  FutureOr<void> _onGetPriority(GetPriority event, Emitter<CreateSupportState> emit) {
    emit(CreateSupportState(bodyPrioritySupport: event.bodyPrioritySupport));
  }

  FutureOr<void> _onAddFile(AddFile event, Emitter<CreateSupportState> emit) {

  }
}