part of 'gallery_bloc.dart';

class GalleryState extends Equatable {
  final Galleries? galleries;
  final NetworkStatus status;

  const GalleryState({ this.galleries, this.status = NetworkStatus.initial});

  GalleryState copyWith({required Galleries? galleries, NetworkStatus? status}) {
    return GalleryState(
      galleries: galleries ?? this.galleries,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [galleries, status];
}