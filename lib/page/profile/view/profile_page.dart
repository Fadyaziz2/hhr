import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import 'content/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.id, this.settings});
  final int? id;
  final Settings? settings;

  static Route route(int? userId, Settings? settings) => MaterialPageRoute(
      builder: (_) => ProfileScreen(
            id: userId,
            settings: settings,
          ));

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
      create: (_) => ProfileBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}', companyUrl: baseUrl))
        ..add(ProfileLoadRequest()),
      child: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('profile'.tr()),
                backgroundColor: mainColor,
                bottom: TabBar(
                  isScrollable: false,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  tabs: [
                    Text(
                      "official".tr(),
                    ),
                    Text(
                      "personal".tr(),
                    ),
                    Text(
                      "financial".tr(),
                    ),
                    Text(
                      "emergency".tr(),
                    ),
                  ],
                ),
                automaticallyImplyLeading: true,
                centerTitle: false,
              ),
              body: ProfileContent(
                settings: settings,
              ))),
    );
  }
}
