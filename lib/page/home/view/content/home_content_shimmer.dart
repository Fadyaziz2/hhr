import 'package:flutter/material.dart';
import '../../../../res/const.dart';
import '../../../../res/shimmers.dart';

class HomeContentShimmer extends StatelessWidget {

  const HomeContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: Image.asset(
            'assets/images/home_background_one.png',
            height: 200.0,
            fit: BoxFit.cover,
            color: colorPrimary,
          ),
        ),
        const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Row(
                children: [
                  Expanded(
                      child: TileShimmer(
                    titleHeight: 12.0,
                  )),
                  SizedBox(
                    width: 120.0,
                  )
                ],
              ),
              TileShimmer(
                isTrailing: true,
                isSubTitle: true,
              ),
              HorizontalListShimmer(),
              SizedBox(
                height: 16.0,
              ),
              RectangularCardShimmer(
                height: 200.0,
                width: double.infinity,
              ),
              SizedBox(
                height: 16.0,
              ),
              RectangularCardShimmer(
                height: 200.0,
                width: double.infinity,
              )
            ],
          ),
        ),
      ],
    );
  }
}
