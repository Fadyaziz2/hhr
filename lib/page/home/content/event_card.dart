import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/const.dart';
import '../models/event_model.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.data, this.days = false, this.onPressed})
      : super(key: key);

  final TodayData? data;
  final bool? days;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: SizedBox(
              width: 125,
              child: Column(
                children: [
                  Image.network(
                    '${data?.image}',
                    height: 25,
                    color: mainColor,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                       Text('${data?.number}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                      if (days == true)
                         const Text(
                          'days',
                          style: TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 4,
                              letterSpacing: 0.5),
                        ),
                    ],
                  ),
                  Text(data?.title ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard2 extends StatelessWidget {
  const EventCard2({Key? key, required this.data, this.days = false, this.onPressed})
      : super(key: key);

  final CurrentMonthData? data;
  final bool? days;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: SizedBox(
              width: 125,
              child: Column(
                children: [
                  Image.network(
                    '${data?.image}',
                    height: 25,
                    color: mainColor,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text('${data?.number}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                      if (days == true)
                        const Text(
                          'days',
                          style: TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 4,
                              letterSpacing: 0.5),
                        ),
                    ],
                  ),
                  Text(data?.title ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
