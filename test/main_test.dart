import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/splash/splash.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late MetaClubApiClient apiClient;
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;

  Widget buildLocalization({required Widget child}) {

    return EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BN'),
        Locale('ar', 'AR')
      ],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: child,
    );
  }

  group('HRM App Initialization', () {
    setUp(() async {
      apiClient = MetaClubApiClient(token: '');
      authenticationRepository = AuthenticationRepository(apiClient: apiClient);
      userRepository = UserRepository(token: '');
      initHydratedStorage();
    });


    testWidgets('Render HRM AppView', (widgetTester) async {
      initHydratedStorage();
       EasyLocalization.ensureInitialized().then((value) async {
         await widgetTester.pumpWidget(buildLocalization(child:App(
             authenticationRepository: authenticationRepository,
             userRepository: userRepository)));
         expect(find.byType(AppView), findsOneWidget);
       });
    });
  });

  group('AppView', () {
    late AuthenticationBloc authBloc;

    setUp(() {
      authBloc = MockAuthenticationBloc();
      when(() => authBloc.state)
          .thenReturn(const AuthenticationState.unknown());
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: authBloc,
        child: const AppView(),
      );
    }

    testWidgets('Render  material app with correct theme', (tester) async {

      initHydratedStorage();
      EasyLocalization.ensureInitialized().then((value) async {
        await tester.pumpWidget(buildLocalization(child: RepositoryProvider.value(
          value: authenticationRepository,
          child: buildSubject(),
        )));
      });

      expect(find.byType(MaterialApp), findsOneWidget);

      ///In future we will implement theme and also test case
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, null);
    });

    testWidgets('Renders SplashScreen', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: authenticationRepository,
        child: buildSubject(),
      ));
      expect(find.byType(SplashScreen), findsOneWidget);
    });
  });
}

class MockStorage extends Mock implements Storage {}

late Storage hydratedStorage;

void initHydratedStorage() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  hydratedStorage = MockStorage();
  when(() => hydratedStorage.write(any(), any<dynamic>()))
      .thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
}
