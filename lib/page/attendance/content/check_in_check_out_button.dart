import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';

class CheckInCheckOutButton extends StatelessWidget {

  final DashboardModel homeData;

  const CheckInCheckOutButton({Key? key,required this.homeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onVerticalDragCancel: () {

        },
        onHorizontalDragCancel: () {

        },
        onTapDown: (_) {

        },
        onTapUp: (_) {

        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const SizedBox(
              height: 175,
              width: 175,
              child: CircularProgressIndicator(
                // strokeWidth: 5,
                value: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Container(
              height: 185,
              width: 185,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorPrimary.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: const CircularProgressIndicator(
                strokeWidth: 5,
                value: 0.5,
                valueColor: AlwaysStoppedAnimation<Color>(colorPrimary),
              ),
            ),
            ClipOval(
              child: Material(
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration:  const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            colorPrimary,
                            Color(0xFF00CCFF)
                          ],
                          begin: FractionalOffset(1.0, 0.0),
                          end: FractionalOffset(0.0, 3.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset(
                              "assets/images/tap_figer.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "check In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
