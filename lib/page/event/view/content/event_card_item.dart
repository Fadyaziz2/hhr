import 'package:club_application/page/event/bloc/event_bloc.dart';
import 'package:club_application/page/event/view/event_details_page.dart';
import 'package:club_application/res/const.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventCardItem extends StatelessWidget {
  final Event event;

  const EventCardItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return Center(
              child: CircularProgressIndicator(
            color: mainColor,
          ));
        }
        if (state.status == NetworkStatus.success) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, EventDetailsPage.route(event));
            },
            child: Container(
              height: 300.0,
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        spreadRadius: 2.0)
                  ]),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: '${event.image}',
                      placeholder: (context, url) => Center(
                        child:
                            Image.asset("assets/images/placeholder.png"),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.network('${event.image}'),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      event.date ?? '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 13.0),
                                    ),
                                  ],
                                ),
                              )),
                          const VerticalDivider(
                            indent: 8.0,
                            endIndent: 8.0,
                            color: Colors.red,
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    event.title ?? event.description ?? '',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    event.startDate ?? '',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 13.0),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: event.going == 0
                                              ? () {
                                                  context.read<EventBloc>().add(
                                                      EventGoingButton(
                                                          eventId: event.id!));
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.deepPurple),
                                          child: const Text(
                                            'GOING',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: event.appreciate == 0 ? () {
                                            context.read<EventBloc>().add(
                                                EventAppreciateButton(
                                                    eventId: event.id!));
                                          } : null,
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.orange),
                                          child: const Text('Appreciate',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

/*@override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTap: () {
        Navigator.push(context, EventDetailsPage.route(event));
      },
      child: Container(
        height: 300.0,
        margin: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 4.0, spreadRadius: 2.0)
            ]),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: '${event.image}',
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/placeholder.png"),
                ),
                errorWidget: (context, url, error) =>
                    Image.network('${event.image}'),
              ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                event.date ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 13.0),
                              ),
                            ],
                          ),
                        )),
                    const VerticalDivider(
                      indent: 8.0,
                      endIndent: 8.0,
                      color: Colors.red,
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              event.title ?? event.description ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            Text(
                              event.startDate ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 13.0),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // context.read<LoginBloc>().add(const LoginSubmit());
                                    },
                                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                                    child: const Text(
                                      'GOING',
                                      style: TextStyle(color: Colors.white,fontSize: 11.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4.0,),
                                Expanded(
                                  child: ElevatedButton(onPressed: () {},style:
                                  ElevatedButton.styleFrom(primary: Colors.orange),
                                    child: const Text('Appreciate', style: TextStyle(color: Colors.white,fontSize: 11.0)),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }*/
}
