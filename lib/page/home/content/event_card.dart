import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/const.dart';
import 'event_card_item.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {Key? key, required this.data, this.days = false, this.onPressed})
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
                      Text(
                        '${data?.number}',
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
                  Text(
                    data?.title ?? '',
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
  const EventCard2(
      {Key? key, required this.data, this.days = false, this.onPressed})
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
                      Text(
                        '${data?.number}',
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
                  Text(
                    data?.title ?? '',
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

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({Key? key, required this.events}) : super(key: key);

  final List<UpcomingEvent> events;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/new_Upcoming_Event.png',
            height: 185,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upcoming events',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        letterSpacing: 0.5)),
                const Text('Public holiday and even',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Color(0xFF555555),
                        letterSpacing: 0.5)),
                const SizedBox(
                  height: 6,
                ),
                Column(
                  children: events
                      .map((e) => EventCardItem(upcomingItems: e))
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
