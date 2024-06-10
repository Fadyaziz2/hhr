import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/splash/view/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import '../../main_test.dart';

void main() async {
  late AuthenticationBloc authenticationBloc;
  late MetaClubApiClient apiClient;
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;

  setUpAll(() async {
    initHydratedStorage();
    apiClient = MetaClubApiClient(httpService: instance());
    authenticationRepository = AuthenticationRepository(hrmCoreBaseService: instance());
    userRepository = UserRepository(token: '');
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableLevels = [];
    await EasyLocalization.ensureInitialized();
    authenticationBloc = AuthenticationBloc(authenticationRepository: authenticationRepository);
  });

  group('Splash screen', () {
    group('Render splash screen', () {
      setUp(() {});
      testWidgets('Find SplashScreen widget', (tester) async {
        await tester.pumpWidget(MultiBlocProvider(providers: [
          BlocProvider(create: (context) => authenticationBloc),
        ], child: const MaterialApp(home: SplashScreen())));
        expect(find.byType(SplashScreen), findsOneWidget);
      });

      testWidgets('Find splash screen logo', (tester) async {
        // final appLogo = Image.asset(
        //   "assets/images/app_icon.png",
        //   scale: 3,
        // );

        await tester.pumpWidget(MultiBlocProvider(providers: [
          BlocProvider(create: (context) => authenticationBloc),
        ], child: const MaterialApp(home: SplashScreen())));
        expect(find.byType(Image), findsOneWidget);
        ///splash screen app logo
        // final logo = tester.widget<Image>(find.byType(Image));
        // expect(logo, appLogo);
      });
    });
  });
}
