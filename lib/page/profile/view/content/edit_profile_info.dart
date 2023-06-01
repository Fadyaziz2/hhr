import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/bloc/profile/profile_bloc.dart';
import 'package:onesthrm/page/profile/bloc/update/update_profile_bloc.dart';
import 'package:onesthrm/res/enum.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import 'edit_profile_content.dart';

class EditOfficialInfo extends StatelessWidget {
  final String? pageName;
  final Settings? settings;
  final Profile? profile;
  final Bloc profileBloc;

  const EditOfficialInfo(
      {Key? key,
      required this.pageName,
      required this.settings,
      required this.profile,
      required this.profileBloc})
      : super(key: key);

  static Route route(
          {required String pageName,
          required Settings? settings,
          required Profile? profile,
          required ProfileBloc bloc}) =>
      MaterialPageRoute(
          builder: (context) => EditOfficialInfo(
                pageName: pageName,
                settings: settings,
                profile: profile,
                profileBloc: bloc,
              ));

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (_) => UpdateProfileBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}')),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Update $pageName data'),
        ),
        body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
          listener: (context, state) {
            if(state.status == NetworkStatus.success){
              profileBloc.add(ProfileLoadRequest());
              Navigator.of(context).pop();
            }
            if(state.status == NetworkStatus.failure){

            }
            if(state.status == NetworkStatus.loading){

            }
          },
          child: EditProfileContent(
            pageName: pageName,
            settings: settings,
            profile: profile,
            bloc: profileBloc,
          ),
        ),
      ),
    );
  }
}
