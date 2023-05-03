import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/profile/view/content/emergency_profile_content.dart';
import 'package:onesthrm/page/profile/view/content/finalcial_profile_content.dart';
import 'package:onesthrm/page/profile/view/content/personal_profile_content.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/profile_bloc.dart';
import 'official_profile_content.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        if (state.profile != null) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: '${state.profile?.official?.avatar}',
                    placeholder: (context, url) => Center(
                      child: Image.asset("assets/images/app_icon.png"),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    state.profile?.official != null ?
                      OfficialProfileContent(official: state.profile!.official!) : const SizedBox.shrink(),
                    state.profile?.personal != null ?
                      PersonalProfileContent(personal: state.profile!.personal!) : const SizedBox.shrink(),
                    state.profile?.financial != null ?
                      FinancialProfileContent(financial: state.profile!.financial!) : const SizedBox.shrink(),
                    state.profile?.emergency != null ?
                      EmergencyProfileContent(emergency: state.profile!.emergency!) : const SizedBox.shrink(),
                  ],
                ),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: const Text(
                            'Are you sure, you want to delete the account'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context)
                                    .add(ProfileDeleteRequest());
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(AuthenticationLogoutRequest());
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes')),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('Delete Account',
                        style: TextStyle(fontSize: 16)),
                  ),
                );
              })
            ],
          );
        }
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text('Failed to load profile'),
        );
      }
      return const SizedBox();
    });
  }
}
