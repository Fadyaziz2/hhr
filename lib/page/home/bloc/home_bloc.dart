import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final MetaClubApiClient _metaClubApiClient;

  HomeBloc({required MetaClubApiClient metaClubApiClient}): _metaClubApiClient = metaClubApiClient, super(const HomeState(status: NetworkStatus.initial)) {
    on<LoadSettings>(_onSettingsLoad);
  }

  void _onSettingsLoad(LoadSettings event, Emitter<HomeState> emit) async {

    emit(const HomeState(status: NetworkStatus.loading));
    try {
      Settings? settings = await _metaClubApiClient.getSettings();

      emit(state.copy(settings: settings,status: NetworkStatus.success));
    } catch (e) {
      emit(const HomeState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
