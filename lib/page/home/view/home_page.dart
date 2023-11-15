import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/content_mars.dart';
import 'package:onesthrm/res/const.dart';
import 'content/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
        body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
          // return state.settings?.data?.appTheme == 1 ? ;
          // return context.watch<HomeBloc>().chooseTheme(state.settings?.data?.appTheme);
          return state.settings?.data?.appTheme == 2 ? const HomeContent() : const HomeMarsContent();
        }));
  }
}
