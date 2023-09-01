import 'package:flutter/material.dart';

import '../../bloc/phonebook_bloc.dart';

class PhonebookDetailsScreen extends StatelessWidget {
  const PhonebookDetailsScreen(
      {Key? key, required this.userId, required this.bloc})
      : super(key: key);
  final String userId;
  final PhonebookBloc bloc;

  static Route route(
      {required PhonebookBloc homeBloc, required String userId}) {
    return MaterialPageRoute(
        builder: (_) => PhonebookDetailsScreen(
              bloc: homeBloc,
              userId: userId,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Directory"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: bloc.onPhonebookDetails(userId: userId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              return Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  ClipOval(
                      child: Image.network(
                    snapshot.data?.data?.avatar ?? '',
                    height: 150,
                    width: 150,
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    snapshot.data?.data?.name ?? "N/A",
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    snapshot.data?.data?.designation ?? "N/A",
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
                        profileMenu(
                            iconData: Icons.call,
                            bgColor: const Color(0xFF3171F9),
                            onPressed: () {
                              bloc.add(DirectPhoneCall(
                                  snapshot.data?.data?.phone ?? ''));
                            }),
                        profileMenu(
                            iconData: Icons.message_outlined,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              bloc.add(DirectMessage(
                                  snapshot.data?.data?.phone ?? ''));
                            }),
                        profileMenu(
                            iconData: Icons.mail,
                            bgColor: const Color(0xFFD8DAE8),
                            onPressed: () {
                              bloc.add(DirectMailTo(snapshot.data?.data?.email ?? '', snapshot.data?.data?.name ?? ''));
                            }),
                        profileMenu(
                          bgColor: const Color(0xFFFD5250),
                          iconData: Icons.calendar_today_outlined,
                          // onPressed: () => NavUtil.navigateScreen(
                          //   context,
                          //   AppointmentCreateScreen(
                          //     id: widget.phonebookDetails!.data!.id,
                          //     navigation: "directory",
                          //   ),
                          // ),
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
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  GestureDetector profileMenu({IconData? iconData, Function()? onPressed, Color? bgColor}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: Icon(iconData, color: Colors.white,),
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
