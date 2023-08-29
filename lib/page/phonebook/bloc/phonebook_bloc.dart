import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';

part 'phonebook_event.dart';

part 'phonebook_state.dart';

enum PullStatus { idle, loading, loaded }

class PhonebookBloc extends Bloc<PhonebookEvent, PhonebookState> {
  final MetaClubApiClient metaClubApiClient;
  List<PhonebookUser>? loadPhonebookUsers = [];

  PhonebookBloc({required this.metaClubApiClient})
      : super(const PhonebookState(status: NetworkStatus.initial)) {
    on<PhonebookLoadRequest>(_onPhonebookDataRequest);
    on<PhonebookSearchData>(_onPhonebookSearch);
    on<PhonebookLoadRefresh>(_onPhonebookLoadRefresh);
    on<PhonebookLoadMore>(_onPhonebookLoadMore);
    on<DepartmentDataRequest>(_onDepartmentDataRequest);
    // on<>
  }

  FutureOr<void> _onPhonebookDataRequest(
      PhonebookLoadRequest event, Emitter<PhonebookState> emit) async {
    loadPhonebookUsers = [];
    emit(const PhonebookState(status: NetworkStatus.loading));
    try {
      final phonebook =
          await metaClubApiClient.getPhonebooks(pageCount: state.pageCount);
      loadPhonebookUsers = phonebook?.data?.users;
      emit(PhonebookState(
          status: NetworkStatus.success, phonebookUsers: loadPhonebookUsers));
      add(DepartmentDataRequest());
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookSearch(
      PhonebookSearchData event, Emitter<PhonebookState> emit) async {
    try {
      final phonebook = await metaClubApiClient.getPhonebooks(
          keywords: event.searchText, pageCount: state.pageCount);
      emit(PhonebookState(
          status: NetworkStatus.success,
          phonebookUsers: phonebook?.data?.users));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookLoadRefresh(
      PhonebookLoadRefresh event, Emitter<PhonebookState> emit) async {
    loadPhonebookUsers = [];
    try {
      emit(const PhonebookState(
          pageCount: 1, refreshStatus: PullStatus.loading));
      final phonebook =
          await metaClubApiClient.getPhonebooks(pageCount: state.pageCount);
      loadPhonebookUsers = phonebook?.data?.users;
      emit(PhonebookState(
          status: NetworkStatus.success,
          phonebookUsers: loadPhonebookUsers,
          pageCount: 1,
          refreshStatus: PullStatus.loaded));
    } on Exception catch (e) {
      emit(const PhonebookState(
          status: NetworkStatus.failure, refreshStatus: PullStatus.idle));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookLoadMore(
      PhonebookLoadMore event, Emitter<PhonebookState> emit) async {
    try {
      int page = state.pageCount;
      // Phonebook? morePhonebook = state.phonebook;
      final phonebook =
          await metaClubApiClient.getPhonebooks(pageCount: ++page);
      if (phonebook?.data?.users?.isNotEmpty == true) {
        var loadedList = [...?loadPhonebookUsers, ...?phonebook?.data?.users];
        emit(PhonebookState(
            status: NetworkStatus.success,
            phonebookUsers: loadedList,
            pageCount: page));
      }
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onDepartmentDataRequest(
      DepartmentDataRequest event, Emitter<PhonebookState> emit) async {
    emit(const PhonebookState(status: NetworkStatus.loading));
    try {
      final departments = await metaClubApiClient.getAllDepartment();
      print(departments?.data?.departments?.length);
      emit(PhonebookState(
          status: NetworkStatus.success,
          phonebookUsers: loadPhonebookUsers,
          listOfDepartments: departments?.data?.departments));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
