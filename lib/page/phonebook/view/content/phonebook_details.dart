import 'package:flutter/material.dart';

import '../../bloc/phonebook_bloc.dart';

class PhonebookDetailsScreen extends StatelessWidget {
  const PhonebookDetailsScreen(
      {Key? key, required this.userId, required this.bloc})
      : super(key: key);
  final String userId;
  final PhonebookBloc bloc;


  static Route route({required PhonebookBloc homeBloc, required String userId}) {
    return MaterialPageRoute(builder: (_) => PhonebookDetailsScreen(bloc: homeBloc, userId: userId,));
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      profileMenu(
                          iconData: Icons.call,
                          onPressed: () {
                            // _makePhoneCall(
                            //     "tel://${widget.phonebookDetails?.data?.phone}");
                          }),
                      profileMenu(iconData: Icons.message),
                      profileMenu(
                          iconData: Icons.mail,
                          onPressed: () {
                            // makeMail(
                            //     "mailto:${widget.phonebookDetails!.data!.email}}");
                          }),
                      profileMenu(iconData: Icons.messenger_outline_outlined),
                      profileMenu(
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
                  const SizedBox(
                    height: 20,
                  ),
                  buildProfileDetails(
                    title: "phone",
                    description: snapshot.data?.data?.phone ?? "n/a",
                  ),
                  buildProfileDetails(
                    title: "email",
                    description: snapshot.data?.data?.email ?? "n/a",
                  ),
                  buildProfileDetails(
                    title: "department",
                    description: snapshot.data?.data?.designation ?? "n/a",
                  ),
                  buildProfileDetails(
                    title: "date_of_birth",
                    description: snapshot.data?.data?.birthDate ?? "n/a",
                  ),
                  buildProfileDetails(
                    title: "blood_group",
                    description: snapshot.data?.data?.bloodGroup ?? "n/a",
                  ),
                  buildProfileDetails(
                    title: "social_media",
                    description: snapshot.data?.data?.facebookLink ?? "n/a",
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

  CircleAvatar profileMenu({IconData? iconData, Function()? onPressed}) {
    return CircleAvatar(
      // backgroundColor: AppColors.colorPrimary,
      child: IconButton(
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Container buildProfileDetails({String? title, description}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
