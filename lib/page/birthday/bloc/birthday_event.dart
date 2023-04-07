part of 'birthday_bloc.dart';

abstract class BirthdayEvent extends Equatable {
  const BirthdayEvent();

  @override
  List<Object?> get props => [];


}

class BirthdayLoadRequest extends BirthdayEvent {}

class BirthWishChanged extends BirthdayEvent {
  final String birthWish;

  const BirthWishChanged({required this.birthWish});

  @override
  List<Object?> get props => [birthWish];
}

class WishSubmitted extends BirthdayEvent {
  final int wishId;
  const WishSubmitted({required this.wishId});

  @override
  List<Object?> get props => [wishId];
}
