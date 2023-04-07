part of'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadRequest extends ProfileEvent {

  final int userId;

  ProfileLoadRequest({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class ProfileDeleteRequest extends ProfileEvent {}
