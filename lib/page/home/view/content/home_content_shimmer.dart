import 'package:flutter/material.dart';
import '../../../../res/const.dart';
import '../../../../res/shimmers.dart';

class HomeContentShimmer extends StatelessWidget {
  const HomeContentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: Image.asset(
            'assets/images/home_background_one.png',
            fit: BoxFit.cover,
            color: colorPrimary,
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            SizedBox(height: 80.0,),
            Row(
              children: [
                Expanded(child: TileShimmer(titleHeight: 12.0,)),
                SizedBox(width: 120.0,)
              ],
            ),
            TileShimmer(isTrailing: true,isSubTitle: true,),
            SizedBox(height: 16.0,),
            HorizontalListShimmer(),
            SizedBox(height: 16.0,),
            RectangularCardShimmer(height: 200.0,width: double.infinity,),
            SizedBox(height: 16.0,),
            RectangularCardShimmer(height: 200.0,width: double.infinity,)
          ],
        ),
      ],
    );
  }
}
