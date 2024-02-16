import 'package:hive/hive.dart';
import '../home/models/attendance_body.dart';

const String checkBoxName = 'checkInOutBox';

class AttendanceService {
  final box = Hive.box<AttendanceBody>(checkBoxName);

  bool isSync = false;

  void checkInOut({required AttendanceBody checkData, required isCheckedIn}) async {
    if (isCheckedIn) {
      if (checkData.date != null) {
        final index = getIndexOfCheckIn(date: checkData.date!);
        box.putAt(index, checkData);
      }
    } else {
      await box.add(checkData);
    }
  }

  void removeCheckData(int index) async {
    await box.deleteAt(index);
  }

  int getIndexOfCheckIn({required String date}) {
    return getAllCheckData().indexWhere((element) => element.date == date);
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
    final checks = box.values.where((element) => element.date == date).toList();
    if (checks.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlreadyInCheckedOut({required String date}) {
    final check = box.values.firstWhere((element) => element.date == date);
    if (check.outTime != null) {
      return true;
    } else {
      return false;
    }
  }

  AttendanceBody? getCheckDataByDate({String? data}) {
    final checkData =
        box.values.where((element) => element.date == data).toList();
    return checkData.isNotEmpty ? checkData.elementAt(0) : null;
  }
}
