import 'dart:io';

import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/attendance_report_summary/bloc/report_bloc.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_menu_tile.dart';

class ProfileDetails extends StatelessWidget {
  final int userId;

  const ProfileDetails({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: FutureBuilder(
        future: context
            .read<ReportBloc>()
            .onPhoneBookDetails(userId: userId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            final profile = snapshot.data?.data;
            final phonebook = UserModel(
                id: profile?.id,
                name: profile?.name,
                email: profile?.email,
                phone: profile?.phone,
                avatar: profile?.avatar);
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  ClipOval(
                    child: Image.network(
                      profile?.avatar ?? '',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    profile?.name ?? "N/A",
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    profile?.designation ?? "N/A",
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileMenuTile(
                            iconData: Icons.call,
                            bgColor: const Color(0xFF3171F9),
                            onPressed: () async {
                              if (!await launchUrl(
                                  Uri.parse("tel://${profile?.phone}"))) {
                                throw 'Could not launch ${Uri.parse("tel://${profile?.phone}")}';
                              }
                            }),
                        ProfileMenuTile(
                            iconData: Icons.message,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              NavUtil.navigateScreen(
                                  context,
                                  ConversationScreen(
                                    user: phonebook,
                                    uid: '${profile?.id}',
                                    primaryColor: colorPrimary,
                                  ));
                            }),
                        ProfileMenuTile(
                            iconData: Icons.sms,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () async {
                              try {
                                if (Platform.isAndroid) {
                                  String uri =
                                      'sms:${profile?.phone}?body=${Uri.encodeComponent("Hello there")}';
                                  await launchUrl(Uri.parse(uri));
                                } else if (Platform.isIOS) {
                                  String uri =
                                      'sms:${profile?.phone}&body=${Uri.encodeComponent("Hello there")}';
                                  await launchUrl(Uri.parse(uri));
                                }
                              } catch (e) {
                                throw Exception(e.toString());
                              }
                            }),
                        ProfileMenuTile(
                            iconData: Icons.mail,
                            bgColor: const Color(0xFFD8DAE8),
                            onPressed: () async {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: profile?.email,
                                queryParameters: {
                                  'subject': 'CallOut user Profile',
                                  'body': profile?.name
                                },
                              );
                              launchUrl(emailLaunchUri);
                            }),
                        ProfileMenuTile(
                          bgColor: const Color(0xFFFD5250),
                          iconData: Icons.calendar_today_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildProfileDetails(
                    title: "Phone",
                    description: snapshot.data?.data?.phone ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "Email",
                    description: snapshot.data?.data?.email ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "Department",
                    description: snapshot.data?.data?.designation ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "Date of Birth",
                    description: snapshot.data?.data?.birthDate ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "Blood Group",
                    description: snapshot.data?.data?.bloodGroup ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "Social Media",
                    description: snapshot.data?.data?.facebookLink ?? "N/A",
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Container buildProfileDetails({String? title, description}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(title!),
          ),
          Expanded(
            flex: 2,
            child: Text(description),
          )
        ],
      ),
    );
  }
}
