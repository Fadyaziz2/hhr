import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:meta_club_api/src/models/body_registration.dart';
import 'package:meta_club_api/src/models/response_qualification.dart';
import '../../../res/enum.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  final MetaClubApiClient metaClubApiClient;

  RegistrationBloc({required this.metaClubApiClient})
      : super(const RegistrationState(
      items: [], selectedItems: [], status: NetworkStatus.initial)) {
    on<RegistrationInitialRequest>(_onRegistrationDataRequest);
    on<SelectedItemEvent>(_onSelectedItemEvent);
    on<SubmitButton>(_onSubmitButton);
    on<OnCountryChanged>(_onCountryChanged);
  }

  void _onCountryChanged(OnCountryChanged event, Emitter<RegistrationState> emit) async {

    final country = event.selectedCountry;

    print('_onCountryChanged Country $country');

    emit(state.copyWith(selectedCountry: country));
  }

  void _onSubmitButton(SubmitButton event, Emitter<RegistrationState> emit) async {
    debugPrint("Button Click : ${event.items.toJson()}");
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final data = await metaClubApiClient.registration(bodyData: event.items.toJson());

      if(data != null) {
        emit(state.copyWith(status: data.result! ? NetworkStatus.successDialog : NetworkStatus.errorDialog,message: data.error ?? 'Registration now on pending'));
      } else {
        emit(state.copyWith(status: NetworkStatus.errorDialog,message: 'Something went wrong, Try again later'));
      }
    } catch (_) {
      emit(state.copyWith(status: NetworkStatus.errorDialog,message: 'Something went wrong, Try again later'));
    }
  }

  void _onSelectedItemEvent(
      SelectedItemEvent event, Emitter<RegistrationState> emit) {
    final List<Qualification> items = [];

    items.addAll(event.items);

    emit(RegistrationState(
        items: state.items,
        selectedItems: items,
        status: NetworkStatus.success));
  }

  void _onRegistrationDataRequest(
    RegistrationInitialRequest event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState(
        status: NetworkStatus.loading, items: [], selectedItems: []));
    try {
      final qualifications = await metaClubApiClient.getQualification();

      if (qualifications != null) {
        final items = qualifications.data
            .map((item) => Datum(name: item.name,id: item.id))
            .toList();
        emit(RegistrationState(
            status: NetworkStatus.success,
            items: items,
            selectedItems: const []));
      } else {
        emit(const RegistrationState(
            status: NetworkStatus.failure, items: [], selectedItems: []));
      }
    } catch (e) {
      emit(const RegistrationState(
          status: NetworkStatus.failure, items: [], selectedItems: []));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
