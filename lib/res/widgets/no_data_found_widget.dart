import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onesthrm/res/const.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String title;
  final String assetImage;

  const NoDataFoundWidget(
      {super.key,
      this.title = 'no_data_found',
      this.assetImage = 'assets/images/no_data_found.json'});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(assetImage, repeat: false, height: 200),
        Text(
          title,
          style: TextStyle(
              color: colorPrimary.withOpacity(0.4),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ).tr(),
      ],
    ));
  }
}
