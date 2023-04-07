part of 'anniversary_bloc.dart';

class AnniversaryState extends Equatable {
  final AnniversaryModel? anniversaries;
  final NetworkStatus status;
  final AnniversaryWish wishText;
  final FormzStatus formStatus;

  const AnniversaryState({
    this.anniversaries,
    this.status = NetworkStatus.initial,
    this.wishText = const AnniversaryWish.pure(),
    this.formStatus = FormzStatus.pure,
  });

  AnniversaryState copyWith(
      { AnniversaryModel? anniversaries,
       NetworkStatus? status,
      AnniversaryWish? wishText,
      FormzStatus? formStatus}) {
    return AnniversaryState(
        anniversaries: anniversaries ?? this.anniversaries,
        status: status ?? this.status,
        formStatus: formStatus ?? this.formStatus,
        wishText: wishText ?? this.wishText);
  }

  @override
  List<Object?> get props => [anniversaries, status, formStatus, wishText];
}
