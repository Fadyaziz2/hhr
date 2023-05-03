import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/edit_profile_info.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';

class OfficialProfileContent extends StatelessWidget {

  final Official official;

  const OfficialProfileContent({Key? key,required this.official}) : super(key: key);

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
              official.name ?? "N/A"),
          buildProfileDetails(
              title: "Email",
              description:
              official.email ?? "N/A"),
          buildProfileDetails(
              title: "Designation",
              description:official.designation ??
                  "N/A"),
          buildProfileDetails(
              title: "Department",
              description:official.department ?? "N/A"),
          buildProfileDetails(
              title: "Manager",
              description:official.designation ??
                  "N/A"),
          buildProfileDetails(
              title: "Date of joinig",
              description:official.joiningDate ??
                  "N/A"),
          buildProfileDetails(
            title: "Employee Type",
            description:official.employeeType ?? "N/A",
          ),
          buildProfileDetails(
              title: "Employee ID",
              description:official.employeeId ?? "N/A"),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton1(onTap: () {
            Navigator.of(context).push(EditProfileInfo.route(pageName: 'official'));
          }, text: 'Edit Official Info',),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
