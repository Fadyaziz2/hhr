import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../bloc/profile/profile_bloc.dart';
import 'edit_profile_info.dart';

class PersonalProfileContent extends StatelessWidget {

  final Profile profile;
  final Settings? settings;

  const PersonalProfileContent({Key? key,required this.profile,this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildProfileDetails(
              title: "Gender",
              description: profile.personal?.gender  ?? "N/A"),
          buildProfileDetails(
              title: "Phone",
              description:  profile.personal?.phone  ?? "N/A"),
          buildProfileDetails(
              title: "Date of Birth",
              description:  profile.personal?.birthDate  ?? "N/A"),
          buildProfileDetails(
              title: "Address",
              description:  profile.personal?.address  ?? "N/A"),
          buildProfileDetails(
              title: "Nationality",
              description:  profile.personal?.nationality  ?? "N/A"),
          buildProfileDetails(
              title: "Passport",
              description:  profile.personal?.passport  ?? "N/A"),
          buildProfileDetails(
              title: "Blood",
              description:  profile.personal?.bloodGroup  ?? "N/A"),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton1(onTap: () {
            Navigator.of(context).push(
                EditOfficialInfo.route(
                    bloc: context.read<ProfileBloc>(),
                    pageName: 'personal',
                    settings: settings,
                    profile: profile));
          }, text: 'Edit Personal Info',),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
