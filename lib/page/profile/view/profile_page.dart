import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import 'content/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key,this.id,this.settings}) : super(key: key);
  final int? id;
  final Settings? settings;

  static Route route(int? userId,Settings? settings) => MaterialPageRoute(
      builder: (_) => ProfileScreen(
        id: userId,
        settings: settings,
      ));



  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (_) => ProfileBloc(metaClubApiClient: MetaClubApiClient(token : '${user?.user?.token}'))..add(ProfileLoadRequest()),
      child: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Profile'),
                backgroundColor: mainColor,
                bottom: const TabBar(
                  isScrollable: false,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 12,
                  ),
                  labelPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  tabs: [
                    Text(
                      "Official",
                    ),
                    Text(
                      "Personal",
                    ),
                    Text(
                      "Financial",
                    ),
                    Text(
                      "Emergency",
                    ),
                  ],
                ),
                automaticallyImplyLeading: true,
                centerTitle: false,
              ),
              body: ProfileContent(settings: settings,))),
    );
  }
}
