part of 'birthday_bloc.dart';

class BirthdayState extends Equatable {
  final BirthListModel? birthdays;
  final NetworkStatus status;
  final FormzStatus formStatus;
  final BirthdayWish birthdayWish;

  const BirthdayState(
      {this.birthdays,
      this.status = NetworkStatus.initial,
      this.formStatus = FormzStatus.pure,
      this.birthdayWish = const BirthdayWish.pure()});

  BirthdayState copyWith(
      { BirthListModel? birthdays,
      NetworkStatus? status,
      BirthdayWish? birthdayWish,
      FormzStatus? formStatus}) {
    return BirthdayState(
        formStatus: formStatus ?? this.formStatus,
        birthdayWish: birthdayWish ?? this.birthdayWish,
        birthdays: birthdays ?? this.birthdays,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [birthdays, status, formStatus, birthdayWish];
}
