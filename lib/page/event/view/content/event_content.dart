import 'package:club_application/page/event/event.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import '../../../../res/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_card_item.dart';

class EventContent extends StatelessWidget {

  const EventContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc,EventState>(
      builder: (context,state){
        if(state.status == NetworkStatus.loading){
          return Center(child: CircularProgressIndicator(color: mainColor,));
        }
        if(state.status == NetworkStatus.success) {
          if(state.events != null) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView.builder(
                itemCount: state.events!.events.length,
                itemBuilder: (context, index) {

                  final event = state.events!.events.elementAt(index);

                  return EventCardItem(event: event,);
                },
              ),
            );
          }
        }
        if (state.status == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
