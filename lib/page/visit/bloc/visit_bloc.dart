import 'dart:async';
import 'dart:io';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';
import '../../../res/dialogs/custom_dialogs.dart';
import '../../../res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'visit_event.dart';

part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final MetaClubApiClient _metaClubApiClient;

  VisitBloc({required MetaClubApiClient metaClubApiClient}): _metaClubApiClient = metaClubApiClient, super(const VisitState()) {
    on<VisitListEvent>(_onVisitList);
    on<HistoryListEvent>(_onHistoryList);
    on<SelectDatePickerEvent>(_onSelectDatePicker);
    on<SelectMonthPickerEvent>(_onSelectMonthPicker);
    on<CreateVisitEvent>(_onCreateVisitEvent);
    on<VisitDetailsEvent>(_onVisitDetails);
    on<VisitGoToPositionEvent>(_onVisitGoToPosition);
    on<VisitCreateNoteEvent>(_onVisitCreateNote);
    on<CreateRescheduleEvent>(_oncCreateReschedule);
    on<VisitCancelEvent>(_onVisitCancel);
    on<VisitStatusEvent>(_onVisitStatus);
    on<VisitUpdateEvent>(_onVisitUpdate);
    on<VisitUploadPhotoEvent>(_onVisitUploadPhoto);
    on<UploadFileEvent>(_onUploadFile);
  }

  FutureOr<void> _onVisitUploadPhoto(VisitUploadPhotoEvent event, Emitter<VisitState> emit) async {
    File? file = await pickFile(event.context);
    if (file != null) {
      add(UploadFileEvent(file: file, bodyImageUpload: event.bodyImageUpload));
    }
  }

  _onUploadFile(UploadFileEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(isImageLoading: true));
    try {
      FileUpload? fileData = await _metaClubApiClient.uploadFile(file: event.file);
      if (fileData?.result == true) {
        if (fileData?.previewUrl != null) {
          event.bodyImageUpload.imageURL = fileData?.previewUrl;
          bool? isSuccess = await _metaClubApiClient.visitUploadImageApi(
              bodyImageUpload: event.bodyImageUpload);
          if (isSuccess) {
            emit(state.copyWith(isImageLoading: false));
            Fluttertoast.showToast(msg: "Image Upload Successfully");
            add(VisitDetailsEvent(visitId: event.bodyImageUpload.id!));
          } else {
            Fluttertoast.showToast(msg: "Image Upload Filed");
          }
        } else {
          Fluttertoast.showToast(msg: "Image Upload Filed");
        }
      } else {
        emit(state.copyWith(isImageLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isImageLoading: false));
    }
  }

  FutureOr<void> _onVisitUpdate(
      VisitUpdateEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .updateVisitApi(bodyUpdateVisit: event.bodyUpdateVisit)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Visit Note Create Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsEvent(visitId: event.bodyUpdateVisit!.id!));
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

  FutureOr<void> _onVisitStatus(
      VisitStatusEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .cancelVisitApi(bodyVisitCancel: event.bodyVisitCancel)
          .then((success) {
        if (success) {
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsEvent(visitId: event.bodyVisitCancel!.visitId!));
          add(VisitListEvent());
          add(HistoryListEvent());
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onVisitCancel(
      VisitCancelEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .cancelVisitApi(bodyVisitCancel: event.bodyVisitCancel)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Cancel Visit Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsEvent(visitId: event.bodyVisitCancel!.visitId!));
          add(VisitListEvent());
          add(HistoryListEvent());
          Navigator.pop(event.context);
        }
      });
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _oncCreateReschedule(CreateRescheduleEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .createRescheduleApi(bodyCreateSchedule: event.bodyCreateSchedule)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Create Reschedule Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsEvent(visitId: event.bodyCreateSchedule!.visitId!));
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

  FutureOr<void> _onVisitCreateNote(VisitCreateNoteEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .visitCreateNoteApi(bodyVisitNote: event.bodyVisitNote)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Visit Note Create Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(VisitDetailsEvent(visitId: event.bodyVisitNote!.visitId!));
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

  FutureOr<void> _onVisitGoToPosition(
      VisitGoToPositionEvent event, Emitter<VisitState> emit) async {
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
      SelectMonthPickerEvent event, Emitter<VisitState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if(date != null){
      String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
      add(HistoryListEvent());
      emit(state.copyWith(
          status: NetworkStatus.success, currentMonth: currentMonth));
    }
  }

  FutureOr<void> _onVisitDetails(
      VisitDetailsEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading,isImageLoading: false));
    try {
      VisitDetailsModel? visitDetailsResponse = await _metaClubApiClient.getVisitDetailsApi(event.visitId);

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
      SelectDatePickerEvent event, Emitter<VisitState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if(date != null){
      String? currentDate = getDateAsString(format: 'yyyy-MM-dd', dateTime: date);
      emit(state.copyWith(
          status: NetworkStatus.success,
          currentDate: currentDate,
          isDateEnable: false));
    }
  }

  FutureOr<void> _onHistoryList(
      HistoryListEvent event, Emitter<VisitState> emit) async {
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

  FutureOr<void> _onVisitList(
      VisitListEvent event, Emitter<VisitState> emit) async {
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
            add(VisitListEvent());
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
