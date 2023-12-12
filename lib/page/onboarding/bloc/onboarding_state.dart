part of "onboarding_bloc.dart";

class OnboardingState extends Equatable {
  final NetworkStatus? status;
  final CompanyListModel? companyListModel;
  final CompanyList? companyList;
  final List<CompanyList>? listOfCompany;

  const OnboardingState(
      {this.status = NetworkStatus.initial,
      this.companyListModel,
      this.companyList,
      this.listOfCompany});

  OnboardingState copyWith(
      {NetworkStatus? status,
      CompanyListModel? companyListModel,
      CompanyList? companyList,
      List<CompanyList>? listOfCompany}) {
    return OnboardingState(
        status: status ?? this.status,
        companyListModel: companyListModel ?? this.companyListModel,
        companyList: companyList ?? this.companyList,
        listOfCompany: listOfCompany ?? this.listOfCompany);
  }

  @override
  List<Object?> get props =>
      [status, companyListModel, companyList, listOfCompany];
}
