import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/emergency_profile_content.dart';
import 'package:onesthrm/page/profile/view/content/finalcial_profile_content.dart';
import 'package:onesthrm/page/profile/view/content/personal_profile_content.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../home/bloc/home_bloc.dart';
import '../../../upload_file/view/upload_content.dart';
import '../../bloc/profile/profile_bloc.dart';
import 'edit_profile_info.dart';
import 'official_profile_content.dart';

class ProfileContent extends StatelessWidget {
  final Settings? settings;

  const ProfileContent({Key? key, required this.settings}) : super(key: key);

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
                child: UploadContent(onFileUploaded: (FileUpload? data) {
                  debugPrint('data ${data?.fileId}');
                  context.read<ProfileBloc>().add(ProfileAvatarUpdate(avatarId: data?.fileId));
                },),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    state.profile?.official != null
                        ? OfficialProfileContent(
                            profile: state.profile!,
                            settings: settings,
                          )
                        : const SizedBox.shrink(),
                    state.profile?.personal != null
                        ? PersonalProfileContent(
                            profile: state.profile!,settings: settings,)
                        : const SizedBox.shrink(),
                    state.profile?.financial != null
                        ? FinancialProfileContent(
                            financial: state.profile!.financial!)
                        : const SizedBox.shrink(),
                    state.profile?.emergency != null
                        ? EmergencyProfileContent(
                            emergency: state.profile!.emergency!)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
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
