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

class PhonebookBloc extends Bloc<PhonebookEvent, PhonebookState> {
  final MetaClubApiClient metaClubApiClient;

  PhonebookBloc({required this.metaClubApiClient})
      : super(const PhonebookState(status: NetworkStatus.initial)) {
    on<PhonebookLoadRequest>(_onPhonebookDataRequest);
    on<PhonebookSearchData>(_onPhonebookSearch);
    on<PhonebookLoadRefresh>(_onPhonebookLoadRefresh);
    on<PhonebookLoadMore>(_onPhonebookLoadMore);
    on<SelectDepartmentValue>(_onSelectDepartmentValue);
    on<SelectDesignationValue>(_onSelectDesignationValue);
    on<DirectPhoneCall>(_onDirectPhoneCall);
    on<DirectMessage>(_onDirectMessage);
    on<DirectMailTo>(_onDirectMailTo);
  }

  FutureOr<void> _onPhonebookDataRequest(PhonebookLoadRequest event, Emitter<PhonebookState> emit) async {

    try {
      final phonebook = await metaClubApiClient.getPhonebooks(
          designationId: state.designations?.id,
          departmentId: state.departments?.id,
          pageCount: state.pageCount);
      final loadPhonebookUsers = phonebook?.data?.users;
      emit(state.copyWith(
          status: NetworkStatus.success, phonebookUsers: loadPhonebookUsers));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookSearch(PhonebookSearchData event, Emitter<PhonebookState> emit) async {
    try {
      final phonebook = await metaClubApiClient.getPhonebooks(keywords: event.searchText, pageCount: event.pageCount!, departmentId: event.departmentId, designationId: event.designationId);
      final loadPhonebookUsers = phonebook?.data?.users;
      emit(state.copyWith(phonebookUsers: loadPhonebookUsers));
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookLoadRefresh(PhonebookLoadRefresh event, Emitter<PhonebookState> emit) async {
    try {
      emit(state.copyWith(pageCount: 1, pullStatus: PullStatus.loading));
      final phonebook = await metaClubApiClient.getPhonebooks(pageCount: state.pageCount);
      emit(PhonebookState(phonebookUsers: phonebook?.data?.users, pageCount: 1, refreshStatus: PullStatus.loaded));

    } on Exception catch (e) {
      emit(const PhonebookState(
          status: NetworkStatus.failure, refreshStatus: PullStatus.idle));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onPhonebookLoadMore(PhonebookLoadMore event, Emitter<PhonebookState> emit) async {
    try {
      int page = state.pageCount;
      final phonebook = await metaClubApiClient.getPhonebooks(pageCount: ++page, designationId: state.designations?.id, departmentId: state.departments?.id);
      if (phonebook?.data?.users?.isNotEmpty == true) {
        final loadedList = [...?state.phonebookUsers, ...?phonebook?.data?.users];
        emit(state.copyWith(phonebookUsers: loadedList,departments: state.departments, designations: state.designations, pageCount: page));
      }
    } on Exception catch (e) {
      emit(const PhonebookState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDepartmentValue(SelectDepartmentValue event, Emitter<PhonebookState> emit) {
    emit(state.copyWith(departments: event.departmentsData, pageCount: 1, searchKey: state.searchKey));
    add(PhonebookSearchData(departmentId: event.departmentsData.id));
  }

  FutureOr<void> _onSelectDesignationValue(SelectDesignationValue event, Emitter<PhonebookState> emit) {
    emit(state.copyWith(designations: event.designationData,departments: null, pageCount: 1, searchKey: state.searchKey));
    add(PhonebookSearchData(designationId: event.designationData.id));
  }

  FutureOr<void> _onDirectPhoneCall(DirectPhoneCall event, Emitter<PhonebookState> emit) async{
    if (!await launchUrl(Uri.parse("tel://${event.phoneNumber}"))) throw 'Could not launch ${Uri.parse("tel://${event.phoneNumber}")}';
  }

  Future<PhonebookDetailsModel?> onPhonebookDetails({required String userId}) async{
    return await metaClubApiClient.getPhonebooksUserDetails(userId: userId);
  }

  FutureOr<void> _onDirectMessage(DirectMessage event, Emitter<PhonebookState> emit)async {
    try {
      if (Platform.isAndroid) {
        String uri = 'sms:${event.phoneNumber}?body=${Uri.encodeComponent("Hello there")}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri = 'sms:${event.phoneNumber}&body=${Uri.encodeComponent("Hello there")}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> _onDirectMailTo(DirectMailTo event, Emitter<PhonebookState> emit) {
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
}
