import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/bottom_navigation/bloc/bottom_nav_cubit.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../content/bottom_nav_content.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const BottomNavigationPage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    globalState.get(companyUrl);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(
            create: (_) => HomeBloc(
                metaClubApiClient: MetaClubApiClient(httpService: instance()),
                attendanceService: attendanceService,
                authenticationRepository: AuthenticationRepository(hrmCoreBaseService: instance()),
                userRepository: UserRepository(token: '${user?.user?.token}'),
                logoutUseCase: instance())
              ..add(LoadSettings())
              ..add(LoadHomeData())),
      ],
      child: const BottomNavContent(),
    );
  }
}
