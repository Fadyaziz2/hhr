import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/custom_build_profile_details.dart';
import '../../../../res/enum.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/profile_bloc.dart';

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
                      child: Image.asset(
                          "assets/images/app_icon.png"),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Name",
                              description:
                                  state.profile?.official?.name ?? "N/A"),
                          buildProfileDetails(
                              title: "Email",
                              description:
                                  state.profile?.official?.email ?? "N/A"),
                          buildProfileDetails(
                              title: "Designation",
                              description:
                                  state.profile?.official?.designation ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Department",
                              description:
                                  state.profile?.official?.department ?? "N/A"),
                          buildProfileDetails(
                              title: "Manager",
                              description:
                                  state.profile?.official?.designation ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Date of joinig",
                              description:
                                  state.profile?.official?.joiningDate ??
                                      "N/A"),
                          buildProfileDetails(
                            title: "Employee Type",
                            description:
                                state.profile?.official?.employeeType ?? "N/A",
                          ),
                          buildProfileDetails(
                              title: "Employee ID",
                              description:
                                  state.profile?.official?.employeeId ?? "N/A"),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Gender",
                              description: state.profile?.personal?.gender  ?? "N/A"),
                          buildProfileDetails(
                              title: "Phone",
                              description: state.profile?.personal?.phone  ?? "N/A"),
                          buildProfileDetails(
                              title: "Date of Birth",
                              description: state.profile?.personal?.birthDate  ?? "N/A"),
                          buildProfileDetails(
                              title: "Address",
                              description: state.profile?.personal?.address  ?? "N/A"),
                          buildProfileDetails(
                              title: "Nationality",
                              description: state.profile?.personal?.nationality  ?? "N/A"),
                          buildProfileDetails(
                              title: "Passport",
                              description: state.profile?.personal?.passport  ?? "N/A"),
                          buildProfileDetails(
                              title: "Blood",
                              description: state.profile?.personal?.bloodGroup  ?? "N/A"),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "TIN",
                              description: state.profile?.financial?.tin  ?? "N/A"),
                          buildProfileDetails(
                              title: "Bank Name",
                              description: state.profile?.financial?.bankName  ?? "N/A"),
                          buildProfileDetails(
                              title: "Bank Account No",
                              description: state.profile?.financial?.bankAccount  ?? "N/A"),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Name",
                              description: state.profile?.emergency?.name  ?? "N/A"),
                          buildProfileDetails(
                              title: "Mobile Number",
                              description: state.profile?.emergency?.mobile  ?? "N/A"),
                          buildProfileDetails(
                              title: "Relationship",
                              description: state.profile?.emergency?.relationship  ?? "N/A"),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
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
