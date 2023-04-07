import 'package:club_application/page/event/event.dart';
import 'package:club_application/page/event/view/content/event_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class EventPage extends StatelessWidget {

  const EventPage({Key? key}) : super(key: key);

  static Route get route {
    return MaterialPageRoute(builder: (_) => const EventPage());
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (_) => EventBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(EventLoadRequest()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Event'),backgroundColor: mainColor,),
        body: const EventContent(),
      ),
    );
  }
}
