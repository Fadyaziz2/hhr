import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/const.dart';
import '../app/global_state.dart';
import '../home/models/attendance_body.dart';

const String checkBoxName = 'checkInOutBox';

class AttendanceService {
  final box = Hive.box<AttendanceBody>(checkBoxName);

  bool isSync = false;

  AttendanceService._();

  Future<bool> checkInOut(
      {required AttendanceBody checkData,
      required isCheckedIn,
      required isCheckedOut,
      bool multipleAttendanceEnabled = false}) async {
    if (isCheckedIn == true) {
      if (checkData.date != null) {
        if (checkData.inTime != null) {
          if (isCheckedOut == true || multipleAttendanceEnabled == false) {
            final index = getLastIndexOfCheckIn(date: checkData.date!);
            try {
              box.putAt(index < 0 ? 0 : index, checkData);
            } catch (_) {
              await box.add(checkData);
            }
          } else {
            await box.add(checkData);
          }
        }
      }
    } else {
      if (checkData.inTime != null && checkData.outTime != null) {
        await box.add(checkData);
      }
    }
    return true;
  }

  Future<bool> offlineCheckInOut({required AttendanceBody checkData, required isCheckedIn, required isCheckedOut, bool multipleAttendanceEnabled = false}) async {
    if (isCheckedIn != isCheckedOut) {
      if (checkData.date != null) {
        if (checkData.inTime != null) {
          if (isCheckedOut == false || multipleAttendanceEnabled == false) {
            final index = getIndexOfCheckIn(date: checkData.date!);
            try {
              box.putAt(index < 0 ? 0 : index, checkData);
            } catch (_) {
              await box.add(checkData);
            }
          } else {
            await box.add(checkData);
          }
        }
      }
    } else {
      if (checkData.inTime != null) {
        await box.add(checkData);
      }
    }
    if(checkData.date != null){
      await refreshHiveData(date: checkData.date!, body: checkData);
    }
    return true;
  }

  void removeCheckData(int index) async {
    await box.deleteAt(index);
  }

  int getIndexOfCheckIn({required String date}) {
    return getAllCheckData().toList().lastIndexWhere((element) => element.date == date, getAllOfflineCheckData().length - 1);
  }

  int getLastIndexOfCheckIn({required String date}) {
    return getAllOfflineCheckData().length - 1;
  }

  refreshHiveData({required String date,required AttendanceBody body}) async {
    final inList = getAllOfflineCheckData().where((e) => e.date == date).map((e) => e.inTime).toList();
    final outList = getAllOfflineCheckData().where((e) => e.date == date).map((e) => e.outTime).toList();
    final times = [...inList,...outList].where((e) => e != null).toList();
    if(times.length > 6){
      try{
        // Convert strings to DateTime objects
        List<DateTime> dateTimeList = times
            .map((time) => DateFormat('h:mm a', 'en').parse(time!))
            .toList();

        // Find the minimum and maximum times
        DateTime minTime = dateTimeList.reduce((value, element) =>
        value.isBefore(element) ? value : element);
        DateTime maxTime = dateTimeList.reduce((value, element) =>
        value.isAfter(element) ? value : element);

        // Format the times to display
        String formattedMinTime = DateFormat('h:mm a', 'en').format(minTime);
        String formattedMaxTime = DateFormat('h:mm a', 'en').format(maxTime);

        await clearCheckOfflineData();

        box.add(body.copyWith(inTime: formattedMinTime,outTime: formattedMaxTime));
      }catch(_){}
    }
  }

  List<AttendanceBody> getAllOfflineCheckData() {
    return box.values.toList().reversed.where((e) => e.isOffline == true).toList();
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

  ///Return all check in/out data except today's
  Map<String, dynamic> getPastCheckInOutDataMap({required String today}) {
    return {
      'data': getAllOfflineCheckData().where((e) => e.date != today).map((e) {
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

  void deleteFilteredCheckInOut({required String today}) async {
    final keys = box.values
        .where((e) => e.isOffline == true && e.date != today)
        .map((e) => box.keyAt(box.values.toList().indexOf(e)))
        .toList();
    if (keys.isNotEmpty) {
      await box.deleteAll(keys);
    }
  }

  int count() {
    return getAllOfflineCheckData().length;
  }

  Future<void> clearCheckOfflineData() async {
    final keys =
        box.values.where((e) => e.isOffline == true).map((e) => box.keyAt(box.values.toList().indexOf(e))).toList();
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
