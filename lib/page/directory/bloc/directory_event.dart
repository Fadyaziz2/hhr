part of 'directory_bloc.dart';

abstract class DirectoryEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DirectoryLoadRequest extends DirectoryEvent{}