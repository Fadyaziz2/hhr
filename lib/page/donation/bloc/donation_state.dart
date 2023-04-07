part of 'donation_bloc.dart';

class DonationState extends Equatable {
  final DonationModel? donationModel;
  final NetworkStatus status;

  const DonationState(
      {this.donationModel, this.status = NetworkStatus.initial});

  DonationState copyWith(
      {DonationModel? donationModel, NetworkStatus? status}) {
    return DonationState(
        donationModel: donationModel ?? this.donationModel,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [donationModel, status];
}
