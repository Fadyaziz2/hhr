import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/bloc/support_event.dart';
import 'package:onesthrm/page/support/bloc/support_state.dart';
import 'package:onesthrm/res/enum.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final MetaClubApiClient _metaClubApiClient;

  SupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const SupportState(status: NetworkStatus.initial)) {
    on<getSupportData>(_onSupportLoad);
  }

  FutureOr<void> _onSupportLoad(
      getSupportData event, Emitter<SupportState> emit) {
    emit(const SupportState(status: NetworkStatus.loading));

    try {
     final response = _metaClubApiClient.getSupport();

    } catch (_) {
      return null;
    }
  }
}
