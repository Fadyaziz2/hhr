import 'package:club_application/page/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_evet.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final MetaClubApiClient metaClubApiClient;

  EventBloc({required this.metaClubApiClient})
      : super(const EventState(status: NetworkStatus.initial)) {
    on<EventLoadRequest>(_onEventLoadRequest);
    on<EventGoingButton>(_onEventGoing);
    on<EventAppreciateButton>(_onAppreciate);
  }

  void _onAppreciate(EventAppreciateButton event, Emitter<EventState> emit) async {
    final data = {"event_id": event.eventId};
    try {
      final events = await metaClubApiClient.postEventAppreciate(data);
      Fluttertoast.showToast(msg: events['message']);
      add(EventLoadRequest());
    } catch (e) {
      emit(const EventState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }


  void _onEventGoing(EventGoingButton event, Emitter<EventState> emit) async {
    final data = {"event_id": event.eventId};
    if (kDebugMode) {
      print(data.toString());
    }
    try {
      final events = await metaClubApiClient.postEventGoing(data);
      Fluttertoast.showToast(msg: events['message']);
      add(EventLoadRequest());
    } catch (e) {
      emit(const EventState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  void _onEventLoadRequest(
      EventLoadRequest event, Emitter<EventState> emit) async {
    emit(const EventState(status: NetworkStatus.loading));
    try {
      final events = await metaClubApiClient.events();
      emit(EventState(status: NetworkStatus.success, events: events));
    } catch (e) {
      emit(const EventState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
