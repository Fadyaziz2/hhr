import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/task/model/status_model.dart';
import 'package:onesthrm/res/enum.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final MetaClubApiClient metaClubApiClient;

  TaskBloc({required this.metaClubApiClient})
      : super(const TaskState(status: NetworkStatus.initial)) {
    on<TaskInitialDataRequest>(_onTaskInitialDataRequest);
    on<TaskListOfDataRequest>(_onTaskListOfDataRequest);
    on<TaskSetDropdownValue>(_onTaskSetDropdownValue);
  }

  FutureOr<void> _onTaskInitialDataRequest(
      TaskInitialDataRequest event, Emitter<TaskState> emit) async {
    try {
      final taskDashboard = await metaClubApiClient.getTaskInitialData();
      emit(TaskState(
          status: NetworkStatus.success, taskDashboardData: taskDashboard));
    } on Exception catch (e) {
      emit(const TaskState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onTaskListOfDataRequest(TaskListOfDataRequest event, Emitter<TaskState> emit) async{
    try {
      final taskDashboard = await metaClubApiClient.getTaskListOfData(state.taskSelectedDropdownValue?.id.toString() ?? '26');
      emit(state.copyWith(status: NetworkStatus.success, taskStatusListResponse: taskDashboard));
    } on Exception catch (e) {
      emit(const TaskState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onTaskSetDropdownValue(TaskSetDropdownValue event, Emitter<TaskState> emit) {
    emit(state.copyWith(taskSelectedDropdownValue: event.taskStatusSetValue));
    add(TaskListOfDataRequest());
  }
}
