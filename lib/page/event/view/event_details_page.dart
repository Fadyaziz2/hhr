import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';

class EventDetailsPage extends StatelessWidget {

  final Event event;

  const EventDetailsPage({Key? key,required this.event}) : super(key: key);

  static Route route(Event event){
    return MaterialPageRoute(builder: (context) => EventDetailsPage(event: event));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:const Text('Event details'),backgroundColor: mainColor,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              event.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Container(

              child: CachedNetworkImage(
                width: double.infinity,
                height: 220.0,
                fit: BoxFit.cover,
                imageUrl: '${event.image}',
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/placeholder.png"),
                ),
                errorWidget: (context, url, error) => Image.network('${event.image}'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'GOING',
                      style: TextStyle(fontSize: 15.0,color: Colors.green),
                    ),
                    Text(
                      '12',
                      style: TextStyle(fontSize: 22.0,color: mainColor),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Appreciate',
                      style: TextStyle(fontSize: 15.0,color: Colors.green),
                    ),
                    Text(
                      '10',
                      style: TextStyle(fontSize: 22.0,color:mainColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Description : ',
              style: TextStyle(fontSize: 13,color: Colors.grey),
            ),
            const SizedBox(height: 10,),
            Text(
              '${event.description}',
              style: const TextStyle(fontSize: 14,height: 1.4),
              textAlign: TextAlign.justify,

            ),
          ],
        ),
      ),
    );
  }
}
