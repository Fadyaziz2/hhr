import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/app/app_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MetaClubApiClient apiClient = MetaClubApiClient(token: '');
  final authenticationRepository = AuthenticationRepository(apiClient: apiClient);
  final userRepository = UserRepository(token: '');


  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  Bloc.observer = AppBlocObserver();

  runZonedGuarded((){
    runApp(App(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
    ));
    }, (error, trace) {
      log('main:runZonedGuarded => ${error.runtimeType} $trace');
    },
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
