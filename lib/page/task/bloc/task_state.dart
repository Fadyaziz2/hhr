part of 'task_bloc.dart';

class TaskState extends Equatable {
  final NetworkStatus status;
  final TaskDashboardModel? taskDashboardData;
  final TaskStatusListResponse? taskStatusListResponse;

  const TaskState({
    required this.status,
    this.taskDashboardData,
    this.taskStatusListResponse,
  });

  TaskState copyWith(
      {NetworkStatus? status,
      TaskDashboardModel? taskDashboardData,
      TaskStatusListResponse? taskStatusListResponse}) {
    return TaskState(
      status: status ?? this.status,
      taskDashboardData: taskDashboardData ?? this.taskDashboardData,
      taskStatusListResponse:
          taskStatusListResponse ?? this.taskStatusListResponse,
    );
  }

  @override
  List<Object?> get props =>
      [status, taskDashboardData, taskStatusListResponse];
}
