part of "onboarding_bloc.dart";

class OnboardingState extends Equatable {
  final NetworkStatus? status;
  final CompanyListModel? companyListModel;

  const OnboardingState(
      {this.status = NetworkStatus.initial, this.companyListModel});

  OnboardingState copyWith(
      {NetworkStatus? status, CompanyListModel? companyListModel}) {
    return OnboardingState(
        status: status ?? this.status,
        companyListModel: companyListModel ?? this.companyListModel);
  }

  @override
  List<Object?> get props => [status, companyListModel];
}
