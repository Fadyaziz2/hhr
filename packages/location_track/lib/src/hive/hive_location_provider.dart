import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../location_track.dart';

String location = 'location';

class HiveLocationProvider{
  var box = Hive.box<LocationModel>(location);

  void add(LocationModel location) async {
    await box.add(location);
  }

  LocationModel? getUserLastPosition() {
    return box.isNotEmpty ? box.values.last : null;
  }

  LocationModel? getUserFirstPosition() {
    return box.isNotEmpty ? box.values.first : null;
  }

  Future<void> deleteAllLocation() async {
    await box.clear();
    if (kDebugMode) {
      print("Delete all Local data ${box.values}");
    }
  }

  List<Map<String, dynamic>> toMapList() {
    return box.values.map((e) => e.toJson()).toList();
  }
}
