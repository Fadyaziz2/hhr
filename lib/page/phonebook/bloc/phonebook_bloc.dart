import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';

part 'phonebook_event.dart';

part 'phonebook_state.dart';

enum PullStatus { idle, loading, loaded }

class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final MetaClubApiClient metaClubApiClient;

  PhoneBookBloc({required this.metaClubApiClient}) : super(const PhoneBookState(status: NetworkStatus.initial)) {
    on<PhoneBookLoadRequest>(_onPhoneBookDataRequest);
    on<PhoneBookSearchData>(_onPhoneBookSearch);
    on<PhoneBookLoadRefresh>(_onPhoneBookLoadRefresh);
    on<PhoneBookLoadMore>(_onPhoneBookLoadMore);
    on<SelectDepartmentValue>(_onSelectDepartmentValue);
    on<SelectDesignationValue>(_onSelectDesignationValue);
    on<DirectPhoneCall>(_onDirectPhoneCall);
    on<DirectMessage>(_onDirectMessage);
    on<DirectMailTo>(_onDirectMailTo);
    on<IsMultiSelectionEnabled>(_onIsMultiSelectionEnabled);
    on<DoMultiSelectionEvent>(_onDoMultiSelection);
  }

  Future<void> _onDoMultiSelection(DoMultiSelectionEvent event, Emitter<PhoneBookState> emit) async {
    if (state.isMultiSelectionEnabled) {
      List<PhoneBookUser> phoneBooks = [...state.selectedItems];
      if (phoneBooks.contains(event.phoneBookUser)) {
        phoneBooks.remove(event.phoneBookUser);
      } else {
        phoneBooks.add(event.phoneBookUser);
      }
      emit(state.copyWith(status: NetworkStatus.success, selectedItems: phoneBooks));
    }
  }

  FutureOr<void> _onPhoneBookDataRequest(PhoneBookLoadRequest event, Emitter<PhoneBookState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final phoneBook = await metaClubApiClient.getPhoneBooks(
        designationId: state.designations?.id, departmentId: state.departments?.id, pageCount: state.pageCount);

    phoneBook.fold((l) {
      emit(const PhoneBookState(status: NetworkStatus.failure));
    }, (r) {
      final loadPhoneBookUsers = r?.data?.users;
      emit(state.copyWith(status: NetworkStatus.success, phoneBookUsers: loadPhoneBookUsers));
    });
  }

  FutureOr<void> _onPhoneBookSearch(PhoneBookSearchData event, Emitter<PhoneBookState> emit) async {
    final phoneBook = await metaClubApiClient.getPhoneBooks(
        keywords: event.searchText,
        pageCount: event.pageCount!,
        departmentId: event.departmentId,
        designationId: event.designationId);

    phoneBook.fold((l) {
      emit(const PhoneBookState(status: NetworkStatus.failure));
    }, (r) {
      final loadPhoneBookUsers = r?.data?.users;
      emit(state.copyWith(phoneBookUsers: loadPhoneBookUsers));
    });
  }

  FutureOr<void> _onPhoneBookLoadRefresh(PhoneBookLoadRefresh event, Emitter<PhoneBookState> emit) async {
    emit(state.copyWith(pageCount: 1, pullStatus: PullStatus.loading));
    final phoneBook = await metaClubApiClient.getPhoneBooks(pageCount: state.pageCount);
    phoneBook.fold((l) {
      emit(const PhoneBookState(status: NetworkStatus.failure, refreshStatus: PullStatus.idle));
    }, (r) {
      emit(PhoneBookState(phoneBookUsers: r?.data?.users, pageCount: 1, refreshStatus: PullStatus.loaded));
    });
  }

  FutureOr<void> _onPhoneBookLoadMore(PhoneBookLoadMore event, Emitter<PhoneBookState> emit) async {
    int page = state.pageCount;
    final phoneBook = await metaClubApiClient.getPhoneBooks(
        pageCount: ++page, designationId: state.designations?.id, departmentId: state.departments?.id);
    phoneBook.fold((l) {
      emit(const PhoneBookState(status: NetworkStatus.failure));
    }, (r) {
      if (r?.data?.users?.isNotEmpty == true) {
        final loadedList = [...?state.phoneBookUsers, ...?r?.data?.users];
        emit(state.copyWith(
            phoneBookUsers: loadedList,
            departments: state.departments,
            designations: state.designations,
            status: NetworkStatus.success,
            pageCount: page));
      }
    });
  }

  FutureOr<void> _onSelectDepartmentValue(SelectDepartmentValue event, Emitter<PhoneBookState> emit) {
    emit(state.copyWith(departments: event.departmentsData, pageCount: 1, searchKey: state.searchKey));
    add(PhoneBookSearchData(departmentId: event.departmentsData.id));
  }

  FutureOr<void> _onSelectDesignationValue(SelectDesignationValue event, Emitter<PhoneBookState> emit) {
    emit(state.copyWith(
        designations: event.designationData, departments: null, pageCount: 1, searchKey: state.searchKey));
    add(PhoneBookSearchData(designationId: event.designationData.id));
  }

  FutureOr<void> _onDirectPhoneCall(DirectPhoneCall event, Emitter<PhoneBookState> emit) async {
    debugPrint('Direct phone call disabled for ${event.phoneNumber}.');
  }

  Future<PhoneBookDetailsModel?> onPhoneBookDetails({required String userId}) async {
    final data = await metaClubApiClient.getPhoneBooksUserDetails(userId: userId);
    return data.fold((l) {
      return null;
    }, (r) {
      return r;
    });
  }

  FutureOr<void> _onDirectMessage(DirectMessage event, Emitter<PhoneBookState> emit) async {
    debugPrint('Direct message disabled for ${event.phoneNumber}.');
  }

  FutureOr<void> _onDirectMailTo(DirectMailTo event, Emitter<PhoneBookState> emit) {
    debugPrint('Direct email disabled for ${event.email}.');
  }

  FutureOr<void> _onIsMultiSelectionEnabled(IsMultiSelectionEnabled event, Emitter<PhoneBookState> emit) {
    emit(state.copyWith(isMultiSelectionEnabled: event.isMultiSelectionEnabled));
  }
}
