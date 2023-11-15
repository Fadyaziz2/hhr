import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/res/const.dart';

class CurrentMonthMars extends StatelessWidget {
  const CurrentMonthMars({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardModel = context.read<HomeBloc>().state.dashboardModel;
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 18),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: primaryBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'current_month',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).tr(),
          const Text(
            'An Overview of your Progress',
            style: TextStyle(
              fontSize: 12,
            ),
          ).tr(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            color: primaryBorderColor,
            height: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "${dashboardModel?.data?.currentMonth?[0].number ?? 0}",
                    style: const TextStyle(
                        color: colorPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${dashboardModel?.data?.currentMonth?[0].title ?? 0}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                color: primaryBorderColor,
                width: 0.5,
                height: 48,
              ),
              Column(
                children: [
                  Text(
                    "${dashboardModel?.data?.currentMonth?[1].number ?? 0}",
                    style: const TextStyle(
                        color: Color(0xffF76B6E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${dashboardModel?.data?.currentMonth?[1].title ?? 0}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                color: primaryBorderColor,
                width: 0.5,
                height: 48,
              ),
              Column(
                children: [
                  Text(
                    "${dashboardModel?.data?.currentMonth?[2].number ?? 0}",
                    style: const TextStyle(
                        color: Color(0xff3DBA90),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${dashboardModel?.data?.currentMonth?[2].title ?? 0}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
