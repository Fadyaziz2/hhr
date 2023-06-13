import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../res/const.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../bottom_navigation/view/bottom_navigation_page.dart';
import '../login/view/login_page.dart';
import '../splash/view/splash.dart';

class App extends StatelessWidget {

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const App(
      {Key? key, required this.authenticationRepository, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository, userRepository: userRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(BottomNavigationPage.route(), (route) => false,);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
                break;
              default:
                break;
            }
          }, child: child,);
      },
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: colorPrimary,
        ),
      ),
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
