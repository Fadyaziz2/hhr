part of 'directory_bloc.dart';

class DirectoryState extends Equatable {
  final Directories? directories;
  final NetworkStatus status;

  const DirectoryState({this.directories, this.status = NetworkStatus.initial});

  DirectoryState copyWith({required Directories? contacts, required NetworkStatus? status}) {
    return DirectoryState(directories: directories ?? directories, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [directories, status];
}
