import 'package:club_application/page/authentication/bloc/authentication_bloc.dart';
import 'package:club_application/page/profile/profile.dart';
import 'package:club_application/page/profile/view/content/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key,this.id}) : super(key: key);
  final int? id;

  static Route route(int? userId) => MaterialPageRoute(
      builder: (_) => ProfileScreen(
        id: userId,
      ));



  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (_) => ProfileBloc(metaClubApiClient: MetaClubApiClient(token : '${user?.token}'))
        ..add(ProfileLoadRequest(userId: id!)),
      child: DefaultTabController(
          length: 3,
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
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  tabs: [
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
              body: const ProfileContent())),
    );
  }
}
