import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/date_utils.dart';
import '../../../res/dialogs/custom_dialogs.dart';
import '../../../res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'visit_event.dart';

part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final MetaClubApiClient _metaClubApiClient;

  VisitBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const VisitState()) {
    on<VisitListApi>(_visitListApi);
    on<HistoryListApi>(_historyListApi);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<SelectMonthPicker>(_onSelectMonthPicker);
    on<CreateVisitEvent>(_onCreateVisitEvent);
    on<VisitDetailsApi>(_visitDetailsApi);
    on<VisitGoToPosition>(_visitGoToPosition);
    on<VisitCreateNoteApi>(_visitCreateNoteApi);
    on<CreateRescheduleApi>(_createRescheduleApi);
    on<VisitCancelApi>(_visitCancelApi);
    on<VisitStatusApi>(_visitStatusApi);
    on<VisitUpdate>(_visitUpdateApi);
    on<VisitUploadPhoto>(_visitUploadPhoto);
    on<UploadFile>(_onUploadFile);
  }

  FutureOr<void> _visitUploadPhoto(
      VisitUploadPhoto event, Emitter<VisitState> emit) async {
    File? file = await pickFile(event.context);
    debugPrint('file ${file?.path}');
    if (file != null) {
      add(UploadFile(file: file, bodyImageUpload: event.bodyImageUpload));
    }
  }

  _onUploadFile(UploadFile event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      FileUpload? fileData =
          await _metaClubApiClient.uploadFile(file: event.file);
      if (fileData?.result == true) {
        // emit(state.copyWith(fileUpload: fileData, status: NetworkStatus.success));
        print("Visit Uploaded URL : ${fileData?.previewUrl}");
        if (fileData?.previewUrl != null) {
          event.bodyImageUpload.imageURL = fileData?.previewUrl;
          bool? isSuccess = await _metaClubApiClient.visitUploadImageApi(
              bodyImageUpload: event.bodyImageUpload);
          if (isSuccess) {
            Fluttertoast.showToast(msg: "Image Upload Successfully");
            add(VisitDetailsApi());
          } else {
            Fluttertoast.showToast(msg: "Image Upload Filed");
          }
        } else {
          Fluttertoast.showToast(msg: "Image Upload Filed");
        }
      } else {
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }

  FutureOr<void> _visitUpdateApi(
      VisitUpdate event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .updateVisitApi(bodyUpdateVisit: event.bodyUpdateVisit)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Visit Note Create Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsApi(visitId: event.bodyUpdateVisit?.id));
          add(VisitListApi());
          Navigator.pop(event.context);
        } else {
          emit(state.copyWith(status: NetworkStatus.failure));
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _visitStatusApi(
      VisitStatusApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .cancelVisitApi(bodyVisitCancel: event.bodyVisitCancel)
          .then((success) {
        if (success) {
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsApi(visitId: event.bodyVisitCancel?.visitId));
          add(VisitListApi());
          add(HistoryListApi());
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _visitCancelApi(
      VisitCancelApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .cancelVisitApi(bodyVisitCancel: event.bodyVisitCancel)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Cancel Visit Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsApi(visitId: event.bodyVisitCancel?.visitId));
          add(VisitListApi());
          add(HistoryListApi());
          Navigator.pop(event.context);
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _createRescheduleApi(
      CreateRescheduleApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .createRescheduleApi(bodyCreateSchedule: event.bodyCreateSchedule)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Create Reschedule Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsApi(visitId: event.bodyCreateSchedule?.visitId));
          Navigator.pop(event.context);
        } else {
          emit(state.copyWith(status: NetworkStatus.failure));
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _visitCreateNoteApi(
      VisitCreateNoteApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .visitCreateNoteApi(bodyVisitNote: event.bodyVisitNote)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Visit Note Create Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsApi(visitId: event.bodyVisitNote?.visitId));
          Navigator.pop(event.context);
        } else {
          emit(state.copyWith(status: NetworkStatus.failure));
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _visitGoToPosition(
      VisitGoToPosition event, Emitter<VisitState> emit) async {
    Set<Marker> markers = {};
    final GoogleMapController controller = event.controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: event.latLng, zoom: 15)));
    markers.add(Marker(
      markerId: MarkerId(event.latLng.latitude.toString()),
      position: LatLng(event.latLng.latitude, event.latLng.longitude),
      //position of marker
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    emit(state.copyWith(markers: markers));
  }

  FutureOr<void> _onSelectMonthPicker(
      SelectMonthPicker event, Emitter<VisitState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(HistoryListApi());
    emit(state.copyWith(
        status: NetworkStatus.success, currentMonth: currentMonth));
  }

  FutureOr<void> _visitDetailsApi(
      VisitDetailsApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      VisitDetailsModel? visitDetailsResponse =
          await _metaClubApiClient.getVisitDetailsApi(event.visitId);

      emit(state.copyWith(
          status: NetworkStatus.success,
          visitDetailsResponse: visitDetailsResponse,
          longitude: event.longitude,
          latitude: event.latitude));
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<VisitState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentDate =
        getDateAsString(format: 'yyyy-MM-dd', dateTime: date!);
    emit(state.copyWith(
        status: NetworkStatus.success,
        currentDate: currentDate,
        isDateEnable: false));
  }

  FutureOr<void> _historyListApi(
      HistoryListApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final historyResponse =
          await _metaClubApiClient.getHistoryList(state.currentMonth);
      emit(state.copyWith(
          status: NetworkStatus.success, historyListResponse: historyResponse));
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _visitListApi(
      VisitListApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final visitResponse = await _metaClubApiClient.getVisitList();
      emit(state.copyWith(
          status: NetworkStatus.success, visitListResponse: visitResponse));
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onCreateVisitEvent(
      CreateVisitEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading, isDateEnable: false));
    try {
      if (state.currentDate?.isNotEmpty == true) {
        await _metaClubApiClient
            .createVisitApi(bodyCreateVisit: event.bodyCreateVisit)
            .then((success) {
          if (success) {
            Fluttertoast.showToast(msg: "Visit Create Successfully");
            emit(state.copyWith(
                status: NetworkStatus.success, isDateEnable: false));
            add(VisitListApi());
            Navigator.pop(event.context);
          } else {
            emit(state.copyWith(status: NetworkStatus.failure));
            Fluttertoast.showToast(msg: "Something went wrong!");
          }
        });
      } else {
        emit(state.copyWith(status: NetworkStatus.success, isDateEnable: true));
      }
    } on Exception catch (e) {
      emit(
          const VisitState(status: NetworkStatus.failure, isDateEnable: false));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
