import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/bottom_navigation/bloc/bottom_nav_cubit.dart';
import '../content/bottom_nav_content.dart';

class BottomNavigationPage extends StatelessWidget {

  const BottomNavigationPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const BottomNavigationPage());
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: const BottomNavContent(),
    );
  }
}
