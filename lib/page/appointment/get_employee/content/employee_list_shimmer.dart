import 'package:flutter/material.dart';
import 'package:onesthrm/res/shimmers.dart';

class EmployeeListShimmer extends StatelessWidget {
  const EmployeeListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            RectangularCardShimmer(
              height: 80.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            RectangularCardShimmer(
              height: 80.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            RectangularCardShimmer(
              height: 80.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            RectangularCardShimmer(
              height: 80.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            RectangularCardShimmer(
              height: 80.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            RectangularCardShimmer(
              height: 80.0,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
