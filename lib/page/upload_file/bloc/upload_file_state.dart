import 'package:equatable/equatable.dart';

class UploadFileState extends Equatable {
  final String? imagePath;
  final int? imageId;

  const UploadFileState({this.imagePath, this.imageId});

  UploadFileState copyWith({String? imagePath, int? imageId}) {
    return UploadFileState(
        imagePath: imagePath ?? this.imagePath,
        imageId: imageId ?? this.imageId);
  }

  @override
  List<Object?> get props => [imageId];
}
