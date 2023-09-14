import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onesthrm/res/const.dart';

class NoListFoundWidget extends StatelessWidget {
  const NoListFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/no_data_found.json',
                repeat: false, height: 200),
            Text(
              'No List Found',
              style: TextStyle(
                  color: colorPrimary.withOpacity(0.4),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}