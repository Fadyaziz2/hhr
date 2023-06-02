import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onesthrm/page/bottom_navigation/bloc/bottom_nav_cubit.dart';
import '../../../res/const.dart';

class BottomNavItem extends StatelessWidget {

  final String icon;
  final bool isSelected;
  final BottomNavTab tab;

  const BottomNavItem({Key? key,required this.icon,required this.isSelected, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        height: 20,
        color: isSelected ? colorPrimary: const Color(0xFF555555),
      ),
      onPressed: () => context.read<BottomNavCubit>().setTab(tab),
    );
  }
}
