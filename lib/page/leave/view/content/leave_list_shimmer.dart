import 'package:flutter/material.dart';
import 'package:onesthrm/res/shimmers.dart';

class LeaveListShimmer extends StatelessWidget {
  const LeaveListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          RectangularCardShimmer(
            height: 80.0,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
