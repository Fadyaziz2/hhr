import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/enum.dart';

part 'phonebook_event.dart';

part 'phonebook_state.dart';

class PhonebookBloc extends Bloc<PhonebookEvent, PhonebookState> {
  final MetaClubApiClient metaClubApiClient;

  PhonebookBloc({required this.metaClubApiClient})
      : super(const PhonebookState(status: NetworkStatus.initial)) {
    on<PhonebookLoadRequest>(_onPhonebookDataRequest);
    on<PhonebookSearchData>(_onPhonebookSearch);
    // on<>
  }

  FutureOr<void> _onPhonebookDataRequest(
      PhonebookLoadRequest event, Emitter<PhonebookState> emit) async {
    emit(const PhonebookState(status: NetworkStatus.loading));
    try {
      final phonebook = await metaClubApiClient.getPhonebooks();
      emit(PhonebookState(status: NetworkStatus.success, phonebook: phonebook));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookSearch(PhonebookSearchData event, Emitter<PhonebookState> emit) async{
    try {
      final phonebook = await metaClubApiClient.getPhonebooks(keywords: event.searchText);
      emit(PhonebookState(status: NetworkStatus.success, phonebook: phonebook));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
