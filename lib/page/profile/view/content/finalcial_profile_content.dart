import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../bloc/profile/profile_bloc.dart';
import 'edit_profile_info.dart';

class FinancialProfileContent extends StatelessWidget {

  final Profile profile;
  final Settings? settings;

  const FinancialProfileContent({Key? key,required this.profile,required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildProfileDetails(
              title: "TIN",
              description: profile.financial?.tin  ?? "N/A"),
          buildProfileDetails(
              title: "Bank Name",
              description: profile.financial?.bankName  ?? "N/A"),
          buildProfileDetails(
              title: "Bank Account No",
              description: profile.financial?.bankAccount  ?? "N/A"),
          const SizedBox(
            height: 16.0,
          ),
          CustomButton1(onTap: () {
            Navigator.of(context).push(
                EditOfficialInfo.route(
                    bloc: context.read<ProfileBloc>(),
                    pageName: 'financial',
                    settings: settings,
                    profile: profile));
          }, text: 'Edit Financial Info',),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
