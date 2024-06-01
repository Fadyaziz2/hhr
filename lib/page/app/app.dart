import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app_permission_page/app_permission_page.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/attendance/bloc/offline_attendance_bloc/offline_attendance_qubit.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../bottom_navigation/view/bottom_navigation_page.dart';
import '../internet_connectivity/bloc/internet_bloc.dart';
import '../language/bloc/language_bloc.dart';
import '../login/view/login_page.dart';
import '../onboarding/bloc/onboarding_bloc.dart';
import '../onboarding/view/onboarding_page.dart';
import '../splash/view/splash.dart';
import 'package:event_bus_plus/event_bus_plus.dart';

// Initialize the Service Bus
final IEventBus eventBus = EventBus();

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const App({super.key, required this.authenticationRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => OnboardingBloc(metaClubApiClient: MetaClubApiClient(httpServiceImpl: instance()))
                ..add(CompanyListEvent())),
          BlocProvider(
              create: (_) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository, userRepository: userRepository)),
          BlocProvider(create: (_) => InternetBloc()..checkConnectionStatus()),
          BlocProvider(create: (context) => LanguageBloc()),
          BlocProvider(create: (context) => OfflineCubit(attendanceService: attendanceService))
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                ///update company data at application initial event
                final company = context.read<OnboardingBloc>().state.selectedCompany;
                globalState.set(companyName, company?.companyName);
                globalState.set(companyId, company?.id);
                globalState.set(companyUrl, company?.url);

                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    SharedUtil.getBoolValue(isDisclosure).then((isDisclosure) {
                      if (isDisclosure) {
                        _navigator.pushAndRemoveUntil(
                          BottomNavigationPage.route(),
                          (route) => false,
                        );
                      } else {
                        _navigator.pushAndRemoveUntil(
                          AppPermissionPage.route(),
                          (route) => false,
                        );
                      }
                    });
                    break;
                  case AuthenticationStatus.unauthenticated:
                    if (context.read<AuthenticationBloc>().state.data != null) {
                      _navigator.pushAndRemoveUntil(BottomNavigationPage.route(), (route) => false);
                    } else {
                      if (company == null) {
                        _navigator.pushAndRemoveUntil(OnboardingPage.route(), (_) => false);
                      } else {
                        _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
                      }
                    }
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
          theme: ThemeData(
            dialogTheme: const DialogTheme(backgroundColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            primaryColor: colorPrimary,
            inputDecorationTheme: InputDecorationTheme(errorStyle: TextStyle(fontSize: 12.r)),
            appBarTheme: AppBarTheme(
                toolbarHeight: 50.r,
                backgroundColor: colorPrimary,
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: colorPrimary),
                iconTheme: IconThemeData(color: Colors.white, size: 18.r),
                titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 16.r)),
            colorScheme: Theme.of(context).colorScheme.copyWith(primary: colorPrimary, background: Colors.white),
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: (_) => SplashScreen.route(),
        );
      },
    );
  }
}
