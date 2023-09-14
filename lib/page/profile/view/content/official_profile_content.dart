import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/edit_profile_info.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../bloc/profile/profile_bloc.dart';

class OfficialProfileContent extends StatelessWidget {

  final Profile profile;
  final Settings? settings;

  const OfficialProfileContent({Key? key,required this.profile,required this.settings}) : super(key: key);

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
              description:
              profile.official?.name ?? "N/A"),
          buildProfileDetails(
              title: "Email",
              description:
              profile.official?.email ?? "N/A"),
          buildProfileDetails(
              title: "Designation",
              description:profile.official?.designation ??
                  "N/A"),
          buildProfileDetails(
              title: "Department",
              description:profile.official?.department ?? "N/A"),
          buildProfileDetails(
              title: "Manager",
              description:profile.official?.designation ??
                  "N/A"),
          buildProfileDetails(
              title: "Date of joining",
              description:profile.official?.joiningDate ??
                  "N/A"),
          buildProfileDetails(
            title: "Employee Type",
            description:profile.official?.employeeType ?? "N/A",
          ),
          buildProfileDetails(
              title: "Employee ID",
              description:profile.official?.employeeId ?? "N/A"),
          const SizedBox(
            height: 24.0,
          ),
          CustomButton1(
            onTap: () {
              Navigator.of(context).push(
                  EditOfficialInfo.route(
                      bloc: context.read<ProfileBloc>(),
                      pageName: 'official',
                      settings: settings,
                      profile: profile));
            },
            text: 'Edit Official Info',
            radius: 4,
          ),
        ],
      ),
    );
  }
}
