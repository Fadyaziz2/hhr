import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/splash/splash.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() async {

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableLevels = [];
    await EasyLocalization.ensureInitialized();
  });

  late MetaClubApiClient apiClient;
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;

  Widget buildLocalization({required Widget child}) {
    return child;
  }

  group('HRM App Initialization', () {
    setUp(() async {
      apiClient = MetaClubApiClient(token: '', companyUrl: '');
      authenticationRepository = AuthenticationRepository(apiClient: apiClient);
      userRepository = UserRepository(token: '');
      initHydratedStorage();
    });

    testWidgets('Render HRM AppView', (widgetTester) async {
      await widgetTester.pumpWidget(App(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository));
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationBloc authBloc;

    setUp(() {
      authBloc = MockAuthenticationBloc();
      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      apiClient = MetaClubApiClient(token: '', companyUrl: '');
      authenticationRepository = AuthenticationRepository(apiClient: apiClient);
      userRepository = UserRepository(token: '');
      initHydratedStorage();
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: authBloc,
        child: const AppView(),
      );
    }

    testWidgets('Render  material app with correct theme', (tester) async {
      await tester.pumpWidget(buildLocalization(
          child: RepositoryProvider.value(
            value: authenticationRepository,
            child: buildSubject(),
          )));

      expect(find.byType(ScreenUtilInit), findsOneWidget);

      ///In future we will implement theme and also test case
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, null);
    });

    testWidgets('Renders SplashScreen', (tester) async {
      EasyLocalization.ensureInitialized().then((value) async {
        await tester.pumpWidget(RepositoryProvider.value(
          value: authenticationRepository,
          child: buildSubject(),
        ));
        expect(find.byType(SplashScreen), findsOneWidget);
      });
    });
  });
}

class MockStorage extends Mock implements Storage {}

class MockFirebase extends Mock implements FirebaseApp {}

late Storage hydratedStorage;

Future<void> initHydratedStorage() async {
  hydratedStorage = MockStorage();
  when(() => hydratedStorage.write(any(), any<dynamic>()))
      .thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
}

initHiveDatabase() async {
  initHydratedStorage();
  // final document = await getApplicationDocumentsDirectory();
  // Hive.init(document.path);
  // Hive.registerAdapter(AttendanceBodyAdapter());
  // await Hive.openBox<AttendanceBody>(checkBoxName);
}
