part of 'acts_regulation_bloc.dart';

class ActsRegulationState extends Equatable {
  final ActsRegulationModel? actsRegulationModel;
  final NetworkStatus? networkStatus;

  const ActsRegulationState(
      {this.actsRegulationModel, this.networkStatus = NetworkStatus.initial});

  ActsRegulationState copyWith(
      {required ActsRegulationModel? actsRegulationModel,
      NetworkStatus? networkStatus}) {
    return ActsRegulationState(
        actsRegulationModel: actsRegulationModel ?? this.actsRegulationModel,
        networkStatus: networkStatus ?? this.networkStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [actsRegulationModel, networkStatus];
}
