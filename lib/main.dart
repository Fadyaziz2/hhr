import 'dart:convert';
import 'dart:io';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/injection/app_injection.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/app/app_bloc_observer.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/res/service/model/notifications/f_c_m_data_model.dart';
import 'package:onesthrm/res/service/notification_service.dart';
import 'package:user_repository/user_repository.dart';
import 'package:path_provider/path_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(AttendanceBodyAdapter());
  await Hive.openBox<AttendanceBody>(checkBoxName);
  ///initializeFirebaseAtStatingPoint
  await Firebase.initializeApp();
  ///initializeDependencyInjection
  await initAppModule();
  ///OtherDependencyInjection
  await AppInjection().initInjection();

  final MetaClubApiClient apiClient = MetaClubApiClient(token: '', companyUrl: '');
  final authenticationRepository = AuthenticationRepository(apiClient: apiClient);
  final userRepository = UserRepository(token: '');

  ///openBox for location hive
  openLocationBox();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  Bloc.observer = AppBlocObserver();

  ///top-level function
  ///to handle background messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'),
      Locale('bn', 'BN'),
      Locale('ar', 'AR'),
    ],
    path: 'assets/translations',
    saveLocale: true,
    fallbackLocale: const Locale('en', 'US'),
    child: App(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
    ),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


///Handle background messaging service
///It must not be an anonymous function.
/// It must be a top-level function (e.g. not a class method which requires initialization).
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification?.title == null) {
    final encodedString = json.encode(message.data);

    ///data class which will parse convert message to model data

    FCMDataModel notification = FCMDataModel.fromJson(message.data);

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
  }
}
