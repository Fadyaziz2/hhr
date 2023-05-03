import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';

class PersonalProfileContent extends StatelessWidget {

  final Personal personal;

  const PersonalProfileContent({Key? key,required this.personal}) : super(key: key);

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
              description: personal.gender  ?? "N/A"),
          buildProfileDetails(
              title: "Phone",
              description: personal.phone  ?? "N/A"),
          buildProfileDetails(
              title: "Date of Birth",
              description: personal.birthDate  ?? "N/A"),
          buildProfileDetails(
              title: "Address",
              description: personal.address  ?? "N/A"),
          buildProfileDetails(
              title: "Nationality",
              description: personal.nationality  ?? "N/A"),
          buildProfileDetails(
              title: "Passport",
              description: personal.passport  ?? "N/A"),
          buildProfileDetails(
              title: "Blood",
              description: personal.bloodGroup  ?? "N/A"),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton1(onTap: () {  }, text: 'Edit Personal Info',),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
