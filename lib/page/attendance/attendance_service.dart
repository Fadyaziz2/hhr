import 'package:hive/hive.dart';
import '../home/models/attendance_body.dart';

const String checkBoxName = 'checkInOutBox';

class AttendanceService {
  final box = Hive.box<AttendanceBody>(checkBoxName);

  bool isSync = false;

  AttendanceService._();

  void checkInOut({required AttendanceBody checkData, required isCheckedIn, required isCheckedOut, bool multipleAttendanceEnabled = false}) async {
    if (isCheckedIn == true) {
      if (checkData.date != null) {
        if(isCheckedOut  == false || multipleAttendanceEnabled == false){
          final index = getIndexOfCheckIn(date: checkData.date!);
          box.putAt(index, checkData);
        }else{
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
    return getAllCheckData().indexWhere((element) => element.date == date,getAllCheckData().length - 1);
  }

  List<AttendanceBody> getAllCheckData() {
    return box.values.toList().reversed.toList();
  }

  List<Map<String, dynamic>> getAllCheckAsMap() {
    return box.values.map((e) => e.toOfflineJson()).toList();
  }

  int count() {
    return getAllCheckData().length;
  }

  void clearCheckData() async {
    await box.clear();
  }

  bool isAlreadyInCheckedIn({required String date}) {
    if(box.values.isNotEmpty){
      final check = getCheckDataByDate(date: date);
      if (check?.inTime != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  bool isAlreadyInCheckedOut({required String date}) {
    if(box.values.isNotEmpty){
      final check = getCheckDataByDate(date: date);
      if (check?.outTime != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  AttendanceBody? getCheckDataByDate({String? date}) {
    if(box.values.isNotEmpty){
      try{
        return box.values.lastWhere((element) => element.date == date);
      }catch(_){
        return null;
      }
    }
    return null;
  }
}

AttendanceService attendanceService = AttendanceService._();