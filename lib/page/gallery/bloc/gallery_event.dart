part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GalleryLoadRequest extends GalleryEvent{}