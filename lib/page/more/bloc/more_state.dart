part of 'more_bloc.dart';

class MoreState extends Equatable {
  final Mores? mores;
  final NetworkStatus status;

  const MoreState({this.mores, this.status = NetworkStatus.initial});

  MoreState copyWith({required Mores? mores,required NetworkStatus? status}) {
    return MoreState(mores: mores ?? this.mores, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [mores, status];
}
