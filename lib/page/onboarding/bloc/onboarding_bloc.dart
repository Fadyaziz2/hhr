import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';




part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final MetaClubApiClient _metaClubApiClient;

  OnboardingBloc({required MetaClubApiClient metaClubApiClient}) : _metaClubApiClient = metaClubApiClient, super(const OnboardingState()){
    on<CompanyListEvent>(_onCompanyList);
  }

  FutureOr<void> _onCompanyList (CompanyListEvent event,Emitter<OnboardingState> emit) async{
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      CompanyListModel? companyList = await _metaClubApiClient.getCompanyList();
      emit(state.copyWith(status: NetworkStatus.success,));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}