import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:url_launcher/url_launcher.dart';
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
    on<SelectDepartmentValue>(_onSelectDepartmentValue);
    on<SelectDesignationValue>(_onSelectDesignationValue);
    on<DirectPhoneCall>(_onDirectPhoneCall);
    // on<>
  }

  FutureOr<void> _onPhonebookDataRequest(
      PhonebookLoadRequest event, Emitter<PhonebookState> emit) async {
    loadPhonebookUsers = [];

    try {
      final phonebook = await metaClubApiClient.getPhonebooks(
          designationId: state.designations?.id,
          departmentId: state.departments?.id,
          pageCount: state.pageCount);
      loadPhonebookUsers = phonebook?.data?.users;
      emit(state.copyWith(
          status: NetworkStatus.success, phonebookUsers: loadPhonebookUsers));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookSearch(
      PhonebookSearchData event, Emitter<PhonebookState> emit) async {
    try {
      final phonebook = await metaClubApiClient.getPhonebooks(keywords: event.searchText, pageCount: state.pageCount, departmentId: state.departments?.id, designationId: state.designations?.id);
      emit(state.copyWith(phonebookUsers: phonebook?.data?.users));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookLoadRefresh(
      PhonebookLoadRefresh event, Emitter<PhonebookState> emit) async {
    loadPhonebookUsers = [];
    try {

      emit(state.copyWith(pageCount: 1, pullStatus: PullStatus.loading));
      final phonebook = await metaClubApiClient.getPhonebooks(pageCount: state.pageCount);
      loadPhonebookUsers = phonebook?.data?.users;
      emit(state.copyWith(phonebookUsers: phonebook?.data?.users, pageCount: 1, pullStatus: PullStatus.loaded));

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
      final phonebook = await metaClubApiClient.getPhonebooks(pageCount: ++page);
      if (phonebook?.data?.users?.isNotEmpty == true) {
        var loadedList = [...?loadPhonebookUsers, ...?phonebook?.data?.users];
        emit(state.copyWith(phonebookUsers: loadedList,departments: state.designations, designations: state.designations, pageCount: page));
      }
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDepartmentValue(SelectDepartmentValue event, Emitter<PhonebookState> emit) {
    emit(state.copyWith(departments: event.departmentsData));
    add(PhonebookSearchData());
  }

  FutureOr<void> _onSelectDesignationValue(SelectDesignationValue event, Emitter<PhonebookState> emit) {
    emit(state.copyWith(designations: event.designationData));
    add(PhonebookSearchData());
  }

  FutureOr<void> _onDirectPhoneCall(DirectPhoneCall event, Emitter<PhonebookState> emit) async{
    if (!await launchUrl(Uri.parse("tel://${event.phoneNumber}"))) throw 'Could not launch ${Uri.parse("tel://${event.phoneNumber}")}';
  }



  Future<PhonebookDetailsModel?> onPhonebookDetails({required String userId}) async{
    return await metaClubApiClient.getPhonebooksUserDetails(userId: userId);
  }
}
