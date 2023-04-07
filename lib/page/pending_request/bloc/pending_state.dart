part of 'pending_bloc.dart';

class PendingState extends Equatable{
  final ResponseUserList? userListReponse;
  final NetworkStatus status;

  const PendingState({this.userListReponse, this.status = NetworkStatus.initial});

  PendingState copyWith({required ResponseUserList? userByIdResponse, required NetworkStatus? status}) {
    return PendingState(userListReponse: userByIdResponse ?? userListReponse, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [userListReponse, status];
}