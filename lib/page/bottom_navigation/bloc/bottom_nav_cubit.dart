import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/main.dart';
import 'package:onesthrm/res/service/model/notifications/notification_data_model.dart';
import 'package:onesthrm/res/service/notification_service.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  BottomNavCubit() : super(const BottomNavState()) {
    initializeFirebaseNotification();
  }

  void setTab(BottomNavTab tab) => emit(BottomNavState(tab: tab));

  void initializeFirebaseNotification() async {
    await Future.delayed(const Duration(seconds: 1));
    _firebaseMessaging
        .getToken()
        .then((value) => debugPrint("token firebase $value"));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      ///encode message.data as payload(String format)
      ///whenever to use payload we have to decode to as map
      final encodedString = json.encode(message.data);

      ///parsing message.data to model data
      NotificationDataModel notification =
          NotificationDataModel.fromJson(message.data);

      ///checking if title null or not if null no notification wi show
      if (notification.image == null) {
        await notificationPlugin.showNotification(
            title: notification.title ?? message.notification?.title,
            body: notification.body ?? message.notification?.body,
            payload: encodedString);
      } else {
        await notificationPlugin.showNotificationWithAttachment(
            title: notification.title ?? message.notification?.title,
            body: notification.body ?? message.notification?.body,
            image: notification.image,
            payload: encodedString);
      }
    });

    notificationPlugin.didReceivedLocalNotificationSubject.listen((value) {
      onNotificationClick(value.payload);
    });

    ///setNotificationClickListener
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  ///notification click event
  onNotificationClick(payload) {
    if (payload != null) {
      if (kDebugMode) {
        print('payload: $payload');
      }

      final map = json.decode(payload);

      NotificationDataModel notificationData =
          NotificationDataModel.fromJson(map);

      if (notificationData.type == 'leave_rejected') {
        navigatorKey.currentState!
            .pushNamed('/leave_details', arguments: notificationData.id);
      } else if (notificationData.type == 'notice') {
        navigatorKey.currentState!
            .pushNamed('/notice_screen', arguments: notificationData.id);
      } else if (notificationData.type == 'check-in') {
        navigatorKey.currentState!
            .pushNamed('/attendance', arguments: notificationData.id);
      } else if (notificationData.type == 'appointments_request') {
        navigatorKey.currentState!
            .pushNamed('/appointment_screen', arguments: notificationData.id);
      }
    }
  }
}
