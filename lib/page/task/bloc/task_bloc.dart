import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/task/model/status_model.dart';
import 'package:onesthrm/page/task/task.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final MetaClubApiClient metaClubApiClient;

  TaskBloc({required this.metaClubApiClient})
      : super(const TaskState(status: NetworkStatus.initial)) {
    on<TaskInitialDataRequest>(_onTaskInitialDataRequest);
    on<TaskListOfDataRequest>(_onTaskListOfDataRequest);
    on<TaskSetDropdownValue>(_onTaskSetDropdownValue);
    on<TaskDetailsStatusRadioValueSet>(_onTaskDetailsStatusRadioValueSet);
    on<TaskDetailsSliderValueSet>(_onTaskDetailsSliderValueSet);
    on<TaskDetailsStatusUpdateRequest>(_onTaskDetailsStatusUpdateRequest);
  }

  FutureOr<void> _onTaskInitialDataRequest(
      TaskInitialDataRequest event, Emitter<TaskState> emit) async {
    try {
      final taskDashboard = await metaClubApiClient.getTaskInitialData();
      emit(TaskState(
          status: NetworkStatus.success, taskDashboardData: taskDashboard));
      add(TaskListOfDataRequest());
    } on Exception catch (e) {
      emit(const TaskState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onTaskListOfDataRequest(
      TaskListOfDataRequest event, Emitter<TaskState> emit) async {
    try {
      final taskDashboard = await metaClubApiClient.getTaskListOfData(
          state.taskSelectedDropdownValue?.id.toString() ?? '26');
      emit(state.copyWith(
          status: NetworkStatus.success,
          taskStatusListResponse: taskDashboard));
    } on Exception catch (e) {
      emit(const TaskState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onTaskSetDropdownValue(
      TaskSetDropdownValue event, Emitter<TaskState> emit) {
    emit(state.copyWith(taskSelectedDropdownValue: event.taskStatusSetValue));
    add(TaskListOfDataRequest());
  }

  Future<TaskDetailsModel?> onTaskDetailsDataRequest(taskId) async {
    return await metaClubApiClient.getTaskDetails(taskId);
  }

  FutureOr<void> _onTaskDetailsStatusRadioValueSet(
      TaskDetailsStatusRadioValueSet event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskDetailsRadioValueSelect: event.statusId));
  }

  FutureOr<void> _onTaskDetailsSliderValueSet(
      TaskDetailsSliderValueSet event, Emitter<TaskState> emit) async {
    emit(state.copyWith(currentSliderValue: event.sliderValue));
  }

  FutureOr<void> _onTaskDetailsStatusUpdateRequest(
      TaskDetailsStatusUpdateRequest event, Emitter<TaskState> emit) async {
    final data = {
      'id': event.id,
      'priority': event.priority,
      'status': state.taskDetailsRadioValueSelect,
      'progress': state.currentSliderValue
    };
    try {
      await metaClubApiClient
          .updateTaskStatusAndSlider(data: data)
          .then((value) {
        add(TaskInitialDataRequest());
        add(TaskListOfDataRequest());
        NavUtil.replaceScreen(
            event.context!,
            TaskScreenDetails(
              taskId: event.id,
              bloc: event.bloccc,
            ));
      });
    } on Exception catch (e) {
      emit(const TaskState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
