import 'package:club_application/res/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/src/models/acts_regulation.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'acts_regulation_event.dart';

part 'acts_regulation_state.dart';

class ActsRegulationBloc
    extends Bloc<ActsRegulationEvent, ActsRegulationState> {
  final MetaClubApiClient clubApiClient;

  ActsRegulationBloc({required this.clubApiClient})
      : super(const ActsRegulationState(networkStatus: NetworkStatus.initial)) {
    on<ActsRequestLoadRequest>(_onLoadRequest);
  }

  _onLoadRequest(
      ActsRequestLoadRequest event, Emitter<ActsRegulationState> emit) async {
    emit(const ActsRegulationState(networkStatus: NetworkStatus.loading));
    try {
      final actsRegulation = await clubApiClient.actsRegulation();
      emit(ActsRegulationState(
          actsRegulationModel: actsRegulation,
          networkStatus: NetworkStatus.success));
    } catch (_) {
      emit(const ActsRegulationState(networkStatus: NetworkStatus.failure));
    }
  }
}
