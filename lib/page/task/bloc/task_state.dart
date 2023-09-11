part of 'task_bloc.dart';

class TaskState extends Equatable {
  final NetworkStatus status;
  final TaskDashboardModel? taskDashboardData;
  final TaskStatusListResponse? taskStatusListResponse;
  final TaskStatusModel? taskSelectedDropdownValue;

  const TaskState(
      {required this.status,
      this.taskDashboardData,
      this.taskStatusListResponse,
      this.taskSelectedDropdownValue});

  TaskState copyWith(
      {NetworkStatus? status,
      TaskDashboardModel? taskDashboardData,
      TaskStatusListResponse? taskStatusListResponse,
      TaskStatusModel? taskSelectedDropdownValue}) {
    return TaskState(
        status: status ?? this.status,
        taskDashboardData: taskDashboardData ?? this.taskDashboardData,
        taskStatusListResponse:
            taskStatusListResponse ?? this.taskStatusListResponse,
        taskSelectedDropdownValue: taskSelectedDropdownValue ?? this.taskSelectedDropdownValue);
  }

  @override
  List<Object?> get props =>
      [status, taskDashboardData, taskStatusListResponse, taskSelectedDropdownValue];
}
