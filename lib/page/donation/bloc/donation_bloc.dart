import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/src/models/donation.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'donation_event.dart';

part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final MetaClubApiClient metaClubApiClient;

  DonationBloc({required this.metaClubApiClient})
      : super(const DonationState(status: NetworkStatus.initial)) {
    on<DonationLoadRequest>(_onDonationDataRequest);
    on<DonationAppreciateSubmitted>(_onAppreciateSubmit);
  }

  void _onAppreciateSubmit(
      DonationAppreciateSubmitted event, Emitter<DonationState> emit) async {
    final data = {"donation_id": event.donationId, "user_id": event.userId};
    // emit(const DonationState(status: NetworkStatus.loading));
    try {
      final events = await metaClubApiClient.postAppreciated(data);

      // emit(state.copyWith(status: NetworkStatus.success));
      Fluttertoast.showToast(msg: events['message']);
      if(events['result'] == true){
        add(DonationLoadRequest());
      }
      debugPrint(events.toString());


    } catch (e) {
      emit(const DonationState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  void _onDonationDataRequest(
      DonationLoadRequest event, Emitter<DonationState> emit) async {
    emit(const DonationState(status: NetworkStatus.loading));
    try {
      final events = await metaClubApiClient.getDonations();
      emit(DonationState(status: NetworkStatus.success, donationModel: events));
    } catch (e) {
      emit(const DonationState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
