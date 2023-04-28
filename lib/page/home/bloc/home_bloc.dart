import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/bloc/home_event.dart';
import 'package:onesthrm/page/home/bloc/home_state.dart';
import '../../../res/enum.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final MetaClubApiClient _metaClubApiClient;

  HomeBloc({required MetaClubApiClient metaClubApiClient}): _metaClubApiClient = metaClubApiClient, super(const HomeState()) {
    on<LoadSettings>(_onSettingsLoad);
  }

  FutureOr<void> _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {
    emit(const HomeState(status: NetworkStatus.loading));
    try {
      Settings? settings = await _metaClubApiClient.getSettings();
      emit(state.copy(settings: settings));
    } catch (e) {
      emit(const HomeState(status: NetworkStatus.failure));
    }
  }
}
