import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/src/models/gallery.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final MetaClubApiClient clubApiClient;

  GalleryBloc({required this.clubApiClient})
      : super(const GalleryState(status: NetworkStatus.initial)) {
    on<GalleryLoadRequest>(_onGalleryDataRequest);
  }

  _onGalleryDataRequest(
      GalleryLoadRequest event, Emitter<GalleryState> emit) async {
    emit(const GalleryState(status: NetworkStatus.loading));
    try {
      final gallery = await clubApiClient.galleries();
      emit(GalleryState(galleries: gallery, status: NetworkStatus.success));
    } catch (_) {
      emit(const GalleryState(status: NetworkStatus.failure));
    }
  }
}
