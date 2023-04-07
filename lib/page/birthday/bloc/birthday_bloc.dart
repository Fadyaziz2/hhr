import 'package:club_application/page/birthday/model/birthday_wish.dart';
import 'package:club_application/res/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/src/models/birthday.dart';

part 'birthday_event.dart';

part 'birthday_state.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  final MetaClubApiClient metaClubApiClient;

  BirthdayBloc({required this.metaClubApiClient})
      : super(const BirthdayState(status: NetworkStatus.initial)) {
    on<BirthdayLoadRequest>(_onBirthDataRequest);
    on<BirthWishChanged>(_onBirthdayChange);
    on<WishSubmitted>(_onSubmitted);
  }

  void _onSubmitted(WishSubmitted event, Emitter<BirthdayState> emit)async{
    final data = {
      "birthday_person_id": event.wishId,
      "message": state.birthdayWish.value
    };
    debugPrint(data.toString());
    if(state.formStatus.isValidated){
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      try{

        final user = await metaClubApiClient.postBirthDayWish(data);

        debugPrint('object $user}');

        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));

        add(BirthdayLoadRequest());

      }catch(_){
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      }
    }
  }

  void _onBirthdayChange(BirthWishChanged event, Emitter<BirthdayState> emit) async {
    final birthdayWish = BirthdayWish.dirty(event.birthWish);
    emit(state.copyWith(birthdayWish: birthdayWish, formStatus : Formz.validate([state.birthdayWish, birthdayWish])));
  }

  void _onBirthDataRequest(BirthdayLoadRequest event, Emitter<BirthdayState> emit) async {
    emit(const BirthdayState(status: NetworkStatus.loading));
    try {
      final events = await metaClubApiClient.getBirthdays();
      emit(BirthdayState(status: NetworkStatus.success, birthdays: events));
    } catch (e) {
      emit(const BirthdayState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
