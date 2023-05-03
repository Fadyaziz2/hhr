import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';

class EmergencyProfileContent extends StatelessWidget {

  final Emergency emergency;

  const EmergencyProfileContent({Key? key,required this.emergency}) : super(key: key);

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
              description: emergency.name  ?? "N/A"),
          buildProfileDetails(
              title: "Mobile Number",
              description: emergency.mobile  ?? "N/A"),
          buildProfileDetails(
              title: "Relationship",
              description: emergency.relationship  ?? "N/A"),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton1(onTap: () {  }, text: 'Edit Emergency Info',),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
