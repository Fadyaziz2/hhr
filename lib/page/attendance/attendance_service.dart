import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:onesthrm/res/const.dart';
import '../app/global_state.dart';
import '../home/models/attendance_body.dart';

const String checkBoxName = 'checkInOutBox';

class AttendanceService {
  final box = Hive.box<AttendanceBody>(checkBoxName);

  bool isSync = false;

  AttendanceService._();

  Future<void> checkInOut(
      {required AttendanceBody checkData,
      required isCheckedIn,
      required isCheckedOut,
      bool multipleAttendanceEnabled = false}) async {
    if (isCheckedIn == true) {
      if (checkData.date != null) {
        if (isCheckedOut == false || multipleAttendanceEnabled == false) {
          final index = getIndexOfCheckIn(date: checkData.date!);
          box.putAt(index < 0 ? 0 : index, checkData);
        } else {
          await box.add(checkData);
        }
      }
    } else {
      await box.add(checkData);
    }
  }

  void removeCheckData(int index) async {
    await box.deleteAt(index);
  }

  int getIndexOfCheckIn({required String date}) {
    return getAllOfflineCheckData().indexWhere(
        (element) => element.date == date, getAllOfflineCheckData().length - 1);
  }

  List<AttendanceBody> getAllOfflineCheckData() {
    return box.values
        .toList()
        .reversed
        .where((e) => e.isOffline == true)
        .toList();
  }

  List<AttendanceBody> getAllCheckData() {
    return box.values.toList().reversed.map((e) => e).toList();
  }

  Map<String, dynamic> getAllCheckInOutDataMap() {
    return {
      'data': getAllOfflineCheckData().map((e) {
        Map<String, dynamic> data = {
          'latitude': e.latitude,
          'longitude': e.longitude,
          'date': e.date,
          'inTime': e.inTime,
          'outTime': e.outTime,
          'reason': e.reason ?? "",
          'remote_mode': e.mode,
          'selfie_image': '',
        };
        return data;
      }).toList()
    };
  }

  Map<String, dynamic> getFilteredCheckInOutDataMap() {
    return {
      'data': getAllOfflineCheckData().where((e) => e.outTime != null).map((e) {
        Map<String, dynamic> data = {
          'latitude': e.latitude,
          'longitude': e.longitude,
          'date': e.date,
          'inTime': e.inTime,
          'outTime': e.outTime,
          'reason': e.reason ?? "",
          'remote_mode': e.mode,
          'selfie_image': '',
        };
        return data;
      }).toList()
    };
  }

  void deleteFilteredCheckInOut() async {
    final keys = box.values
        .where((e) => e.isOffline == true && e.outTime != null)
        .map((e) => box.keyAt(box.values.toList().indexOf(e)))
        .toList();
    if (keys.isNotEmpty) {
      await box.deleteAll(keys);
    }
  }

  int count() {
    return getAllOfflineCheckData().length;
  }

  void clearCheckOfflineData() async {
    final keys = box.values
        .where((e) => e.isOffline == true)
        .map((e) => box.keyAt(box.values.toList().indexOf(e)))
        .toList();
    if (keys.isNotEmpty) {
      await box.deleteAll(keys);
    }
  }

  void clearCheckData() async {
    if (count() < 1) {
      await box.clear();
    }
  }

  bool isAlreadyInCheckedIn({required String date}) {
    if (getAllCheckData().isNotEmpty) {
      final check = getCheckDataByDate(date: date);
      if (check?.inTime != null) {
        globalState.set(inTime, check?.inTime);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  bool isAlreadyInCheckedOut({required String date}) {
    if (getAllCheckData().isNotEmpty) {
      final check = getCheckDataByDate(date: date);
      if (check?.outTime != null) {
        globalState.set(inTime, check?.inTime);
        globalState.set(outTime, check?.outTime);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  AttendanceBody? getCheckDataByDate({String? date}) {
    if (getAllCheckData().isNotEmpty) {
      try {
        return box.values.lastWhere((element) => element.date == date);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

AttendanceService attendanceService = AttendanceService._();
