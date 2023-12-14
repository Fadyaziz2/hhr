import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/app/app_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  ///initializeFirebaseAtStatingPoint
  await Firebase.initializeApp();
  final MetaClubApiClient apiClient = MetaClubApiClient(token: '', companyUrl: '');
  final authenticationRepository =
      AuthenticationRepository(apiClient: apiClient);
  final userRepository = UserRepository(token: '');

  ///openBox for location hive
  openLocationBox();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  Bloc.observer = AppBlocObserver();

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
