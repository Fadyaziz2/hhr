import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseRepository {
  static Future sendLocationToFirebase(userId, locationMap) async {
    return FirebaseFirestore.instance
        .collection('hrm_employee_track')
        .doc('$userId')
        .set(locationMap)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }
}
