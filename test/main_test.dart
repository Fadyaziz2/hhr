import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() async {
  late AuthenticationBloc authenticationBloc;
  late MetaClubApiClient apiClient;
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;
  setUpAll(() async {
    initHydratedStorage();
    apiClient = MetaClubApiClient(token: '', companyUrl: '');
    authenticationRepository = AuthenticationRepository(apiClient: apiClient);
    userRepository = UserRepository(token: '');
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableLevels = [];
    await EasyLocalization.ensureInitialized();
    authenticationBloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
        userRepository: userRepository);
  });

  Widget buildLocalization({required Widget child}) {
    return child;
  }

  group('HRM App Initialization', () {
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

    testWidgets('Render ScreenUtilInit widget', (tester) async {
      await tester.pumpWidget(buildLocalization(
          child: RepositoryProvider.value(
        value: authenticationRepository,
        child: buildSubject(),
      )));

      expect(find.byType(ScreenUtilInit), findsOneWidget);
    });

    testWidgets('Render material theme', (tester) async {
      await tester.pumpWidget(const MaterialApp());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Material theme data check', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: const Scaffold(),
      ));

      ///In future we will implement theme and also test case
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
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
