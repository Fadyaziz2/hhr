import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/const.dart';
import '../../app/global_state.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends HydratedBloc<OnboardingEvent, OnboardingState> {
  final MetaClubApiClient _metaClubApiClient;

  OnboardingBloc({required MetaClubApiClient metaClubApiClient}) : _metaClubApiClient = metaClubApiClient, super(const OnboardingState()){
    on<CompanyListEvent>(_onCompanyLoaded);
    on<OnSelectedCompanyEvent>(_onSelectedCompany);
  }

  FutureOr<void> _onSelectedCompany(OnSelectedCompanyEvent event,Emitter<OnboardingState> emit) async{
    final company = event.selectedCompany;
    globalState.set(companyName, company.companyName);
    globalState.set(companyId, company.id);
    globalState.set(companyUrl, company.url);
    emit(state.copyWith(selectedCompany: company));
  }

  FutureOr<void> _onCompanyLoaded (CompanyListEvent event,Emitter<OnboardingState> emit) async{
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      CompanyListModel? companyModel = await _metaClubApiClient.getCompanyList();
      List<Company> companies = companyModel?.companyList ?? [];
      if(companies.isNotEmpty){
        emit(state.copyWith(selectedCompany: companies.first));
      }
      emit(state.copyWith(status: NetworkStatus.success,companyListModel: companyModel));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) {
    return OnboardingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return state.toJson();
  }
}