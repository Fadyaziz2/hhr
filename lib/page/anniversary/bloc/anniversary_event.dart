part of 'anniversary_bloc.dart';

abstract class AnniversaryEvent extends Equatable {
  const AnniversaryEvent();

  @override
  List<Object?> get props => [];
}

class AnniversaryLoadRequest extends AnniversaryEvent {}

class AnniversaryWishChanged extends AnniversaryEvent {
  final String wishText;

  const AnniversaryWishChanged({required this.wishText});

  @override
  List<Object?> get props => [wishText];
}

class WishSubmitted extends AnniversaryEvent {
  final int wishId;
  const WishSubmitted({required this.wishId});

  @override
  List<Object?> get props => [wishId];
}

