import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final MetaClubApiClient metaClubApiClient;

  ProfileBloc({required this.metaClubApiClient})
      : super(const ProfileState(status: NetworkStatus.initial)) {
    on<ProfileLoadRequest>(_onProfileDataRequest);
    on<ProfileDeleteRequest>(_onAuthenticationDeleteRequest);
  }

  void _onProfileDataRequest(
      ProfileLoadRequest event, Emitter<ProfileState> emit,) async {
    emit(const ProfileState(status: NetworkStatus.loading));
    try {
      final profile = await metaClubApiClient.getProfile();
      emit(ProfileState(status: NetworkStatus.success, profile: profile));
    } catch (e) {
      emit(const ProfileState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  _onAuthenticationDeleteRequest(ProfileDeleteRequest event,Emitter<ProfileState> emit) async {
    final isDeleted = await metaClubApiClient.deleteAccount();
  }

}
