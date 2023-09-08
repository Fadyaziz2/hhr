part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitialDataRequest extends TaskEvent {
  TaskInitialDataRequest();

  @override
  List<Object?> get props => [];
}

class TaskListOfDataRequest extends TaskEvent {
  final String? statusId;

  TaskListOfDataRequest({this.statusId});

  @override
  List<Object?> get props => [statusId];
}
