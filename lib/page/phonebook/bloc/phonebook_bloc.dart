import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> _onDoMultiSelection(DoMultiSelectionEvent event,Emitter<PhoneBookState> emit) async{
    if(state.isMultiSelectionEnabled){
      List<PhoneBookUser> phoneBooks = [...state.selectedItems];
      if(phoneBooks.contains(event.phoneBookUser)){
        phoneBooks.remove(event.phoneBookUser);
      } else {
        phoneBooks.add(event.phoneBookUser);
      }
      emit(state.copyWith(status: NetworkStatus.success,selectedItems: phoneBooks));
    }
  }

  FutureOr<void> _onPhoneBookDataRequest(
      PhoneBookLoadRequest event, Emitter<PhoneBookState> emit) async {

    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final phoneBook = await metaClubApiClient.getPhoneBooks(
          designationId: state.designations?.id,
          departmentId: state.departments?.id,
          pageCount: state.pageCount);
      final loadPhoneBookUsers = phoneBook?.data?.users;
      emit(state.copyWith(
          status: NetworkStatus.success, phoneBookUsers: loadPhoneBookUsers));
    } on Exception catch (e) {
      emit(const PhoneBookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhoneBookSearch(
      PhoneBookSearchData event, Emitter<PhoneBookState> emit) async {
    try {
      final phoneBook = await metaClubApiClient.getPhoneBooks(
          keywords: event.searchText,
          pageCount: event.pageCount!,
          departmentId: event.departmentId,
          designationId: event.designationId);
      final loadPhoneBookUsers = phoneBook?.data?.users;
      emit(state.copyWith(phoneBookUsers: loadPhoneBookUsers));
    } on Exception catch (e) {
      emit(const PhoneBookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhoneBookLoadRefresh(
      PhoneBookLoadRefresh event, Emitter<PhoneBookState> emit) async {
    try {
      emit(state.copyWith(pageCount: 1, pullStatus: PullStatus.loading));
      final phoneBook =
          await metaClubApiClient.getPhoneBooks(pageCount: state.pageCount);
      emit(PhoneBookState(
          phoneBookUsers: phoneBook?.data?.users,
          pageCount: 1,
          refreshStatus: PullStatus.loaded));
    } on Exception catch (e) {
      emit(const PhoneBookState(
          status: NetworkStatus.failure, refreshStatus: PullStatus.idle));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhoneBookLoadMore(
      PhoneBookLoadMore event, Emitter<PhoneBookState> emit) async {
    try {
      int page = state.pageCount;
      final phoneBook = await metaClubApiClient.getPhoneBooks(
          pageCount: ++page,
          designationId: state.designations?.id,
          departmentId: state.departments?.id);
      if (phoneBook?.data?.users?.isNotEmpty == true) {
        final loadedList = [
          ...?state.phoneBookUsers,
          ...?phoneBook?.data?.users
        ];
        emit(state.copyWith(
            phoneBookUsers: loadedList,
            departments: state.departments,
            designations: state.designations,
            status: NetworkStatus.success,
            pageCount: page));
      }
    } on Exception catch (e) {
      emit(const PhoneBookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDepartmentValue(
      SelectDepartmentValue event, Emitter<PhoneBookState> emit) {
    emit(state.copyWith(
        departments: event.departmentsData,
        pageCount: 1,
        searchKey: state.searchKey));
    add(PhoneBookSearchData(departmentId: event.departmentsData.id));
  }

  FutureOr<void> _onSelectDesignationValue(
      SelectDesignationValue event, Emitter<PhoneBookState> emit) {
    emit(state.copyWith(
        designations: event.designationData,
        departments: null,
        pageCount: 1,
        searchKey: state.searchKey));
    add(PhoneBookSearchData(designationId: event.designationData.id));
  }

  FutureOr<void> _onDirectPhoneCall(
      DirectPhoneCall event, Emitter<PhoneBookState> emit) async {
    if (!await launchUrl(Uri.parse("tel://${event.phoneNumber}"))) {
      throw 'Could not launch ${Uri.parse("tel://${event.phoneNumber}")}';
    }
  }

  Future<PhoneBookDetailsModel?> onPhoneBookDetails(
      {required String userId}) async {
    return await metaClubApiClient.getPhoneBooksUserDetails(userId: userId);
  }

  FutureOr<void> _onDirectMessage(
      DirectMessage event, Emitter<PhoneBookState> emit) async {
    try {
      if (Platform.isAndroid) {
        String uri =
            'sms:${event.phoneNumber}?body=${Uri.encodeComponent("Hello there")}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri =
            'sms:${event.phoneNumber}&body=${Uri.encodeComponent("Hello there")}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> _onDirectMailTo(
      DirectMailTo event, Emitter<PhoneBookState> emit) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: event.email,
      queryParameters: {
        'subject': 'CallOut user Profile',
        'body': event.userName
      },
    );
    launchUrl(emailLaunchUri);
  }

  FutureOr<void> _onIsMultiSelectionEnabled(IsMultiSelectionEnabled event, Emitter<PhoneBookState> emit) {
    emit(state.copyWith(isMultiSelectionEnabled: event.isMultiSelectionEnabled));
  }
}
