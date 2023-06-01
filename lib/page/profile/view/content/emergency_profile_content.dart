import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../bloc/profile/profile_bloc.dart';
import 'edit_profile_info.dart';

class EmergencyProfileContent extends StatelessWidget {

  final Profile profile;
  final Settings? settings;

  const EmergencyProfileContent({Key? key,required this.profile,required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildProfileDetails(
              title: "Name",
              description: profile.emergency?.name  ?? "N/A"),
          buildProfileDetails(
              title: "Mobile Number",
              description: profile.emergency?.mobile  ?? "N/A"),
          buildProfileDetails(
              title: "Relationship",
              description: profile.emergency?.relationship  ?? "N/A"),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton1(onTap: () {
            Navigator.of(context).push(
                EditOfficialInfo.route(
                    bloc: context.read<ProfileBloc>(),
                    pageName: 'emergency',
                    settings: settings,
                    profile: profile));
          }, text: 'Edit Emergency Info',),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
