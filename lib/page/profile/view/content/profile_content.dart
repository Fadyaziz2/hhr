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
        if (state.userByIdResponse != null) {
          return Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
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
                                imageUrl:
                                    '${state.userByIdResponse?.data?.avatar}',
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Name",
                              description:
                                  state.userByIdResponse?.data?.name ?? "N/A"),
                          buildProfileDetails(
                              title: "Email",
                              description:
                                  state.userByIdResponse?.data?.email ?? "N/A"),
                          buildProfileDetails(
                              title: "Father Name",
                              description:
                                  state.userByIdResponse?.data?.fatherName ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Mother Name",
                              description:
                                  state.userByIdResponse?.data?.motherName ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Gender",
                              description:
                                  state.userByIdResponse?.data?.gender ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Phone",
                              description:
                                  state.userByIdResponse?.data?.phone ?? "N/A"),
                          buildProfileDetails(
                            title: "Date of Birth",
                            description:
                                state.userByIdResponse?.data?.birthDate ??
                                    "N/A",
                          ),
                          buildProfileDetails(
                              title: "Permanent Address",
                              description: state.userByIdResponse?.data
                                      ?.permanentAddress ??
                                  "N/A"),
                          buildProfileDetails(
                              title: "Nationality",
                              description:
                                  state.userByIdResponse?.data?.nationality ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Passport",
                              description: state
                                      .userByIdResponse?.data?.passportNumber ??
                                  "N/A"),
                          buildProfileDetails(
                              title: "Blood Group",
                              description:
                                  state.userByIdResponse?.data?.bloodGroup ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Mailing Address",
                              description: state
                                      .userByIdResponse?.data?.mailingAddress ??
                                  "N/A"),
                          buildProfileDetails(
                              title: "Organization",
                              description:
                                  state.userByIdResponse?.data?.organization ??
                                      "N/A"),
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
                          Center(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                imageUrl:
                                    '${state.userByIdResponse?.data?.avatar}',
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Tin",
                              description:
                                  state.userByIdResponse?.data?.tin ?? "N/A"),
                          buildProfileDetails(
                              title: "Bank Name",
                              description:
                                  state.userByIdResponse?.data?.bankName ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Bank Account",
                              description:
                                  state.userByIdResponse?.data?.bankAccount ??
                                      "N/A"),
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
                          Center(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                imageUrl:
                                    '${state.userByIdResponse?.data?.avatar}',
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Emergency Name",
                              description:
                                  state.userByIdResponse?.data?.emergencyName ??
                                      "N/A"),
                          buildProfileDetails(
                              title: "Emergency Mobile Number",
                              description: state.userByIdResponse?.data
                                      ?.emergencyMobileNumber ??
                                  "N/A"),
                          buildProfileDetails(
                              title: "Emergency Mobile Relationship",
                              description: state.userByIdResponse?.data
                                      ?.emergencyMobileRelationship ??
                                  "N/A"),
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
                          Center(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                imageUrl:
                                '${state.userByIdResponse?.data?.avatar}',
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildProfileDetails(
                              title: "Emergency Name",
                              description:
                              state.userByIdResponse?.data?.emergencyName ??
                                  "N/A"),
                          buildProfileDetails(
                              title: "Emergency Mobile Number",
                              description: state.userByIdResponse?.data
                                  ?.emergencyMobileNumber ??
                                  "N/A"),
                          buildProfileDetails(
                              title: "Emergency Mobile Relationship",
                              description: state.userByIdResponse?.data
                                  ?.emergencyMobileRelationship ??
                                  "N/A"),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
                return  SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: const Text('Are you sure, you want to delete the account'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context).add(ProfileDeleteRequest());
                                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequest());
                                Navigator.of(context).pop();
                              }, child: const Text('Yes')),
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
