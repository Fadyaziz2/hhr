part of'profile_bloc.dart';

class ProfileState extends Equatable {
  final GetUserByIdResponse? userByIdResponse;
  final NetworkStatus status;

  const ProfileState(
      {this.userByIdResponse, this.status = NetworkStatus.initial});

  ProfileState copyWith(
      {GetUserByIdResponse? userByIdResponse, NetworkStatus? status}) {
    return ProfileState(
        userByIdResponse: userByIdResponse ?? this.userByIdResponse,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [userByIdResponse, status];
}
