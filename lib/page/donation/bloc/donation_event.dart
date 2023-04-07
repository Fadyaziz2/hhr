part of 'donation_bloc.dart';

abstract class DonationEvent extends Equatable{
  const DonationEvent();

  @override
  List<Object?> get props => [];
}

class DonationLoadRequest extends DonationEvent{}

class DonationSubmitted extends DonationEvent{}

class DonationAppreciateSubmitted extends DonationEvent{
  final int donationId;
  final int userId;

  const DonationAppreciateSubmitted({required this.donationId,required this.userId});

  @override
  List<Object?> get props => [donationId, userId];
}