import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/bottom_navigation/bloc/bottom_nav_cubit.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import '../content/bottom_nav_content.dart';

typedef BottomNavigationFactory = BottomNavigationPage Function({required HomeBlocFactory homeBlocFactory});

class BottomNavigationPage extends StatelessWidget {
  final HomeBlocFactory homeBlocFactor;

  const BottomNavigationPage({super.key,required this.homeBlocFactor});

  static Route route({required HomeBlocFactory homeBlocFactor}) {
    return MaterialPageRoute(builder: (_) => BottomNavigationPage(homeBlocFactor: homeBlocFactor));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider<HomeBloc>(
            create: (_) => homeBlocFactor()
              ..add(LoadSettings())
              ..add(LoadHomeData())),
      ],
      child: const BottomNavContent(),
    );
  }
}
