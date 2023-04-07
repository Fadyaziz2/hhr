import 'package:club_application/page/anniversary/model/AnniversaryWish.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta_club_api/src/models/anniversary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'anniversary_event.dart';

part 'anniversary_state.dart';

class AnniversaryBloc extends Bloc<AnniversaryEvent, AnniversaryState> {
  final MetaClubApiClient metaClubApiClient;

  AnniversaryBloc({required this.metaClubApiClient})
      : super(const AnniversaryState(status: NetworkStatus.initial)) {
    on<AnniversaryLoadRequest>(_onAnniversaryDataRequest);
    on<AnniversaryWishChanged>(_onWishChanged);
    on<WishSubmitted>(_onWishSubmitted);
  }

  void _onWishSubmitted(WishSubmitted event, Emitter<AnniversaryState> emit)async{
    final data = {
      "anniversary_person_id": event.wishId,
      "message": state.wishText.value
    };
    debugPrint(data.toString());
    if(state.formStatus.isValidated){
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      try{

        final user = await metaClubApiClient.postAnniversaryWish(data);

        debugPrint('object $user}');

        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));

        add(AnniversaryLoadRequest());

      }catch(_){
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      }
    }

  }

  void _onWishChanged(
      AnniversaryWishChanged event, Emitter<AnniversaryState> emit) {
    final anniversaryWish = AnniversaryWish.dirty(event.wishText);
    emit(state.copyWith(
        wishText: anniversaryWish,
        formStatus: Formz.validate([state.wishText, anniversaryWish])));
  }

  void _onAnniversaryDataRequest(
      AnniversaryLoadRequest event, Emitter<AnniversaryState> emit) async {
    emit(const AnniversaryState(status: NetworkStatus.loading));
    try {
      final events = await metaClubApiClient.getAnniversaries();
      emit(AnniversaryState(
          status: NetworkStatus.success, anniversaries: events));
    } catch (e) {
      emit(const AnniversaryState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
