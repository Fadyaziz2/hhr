import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/phonebook.dart';

class PhonebookUserList extends StatelessWidget {
  const PhonebookUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // itemCount: allUserProvider.responseAllUser?.data?.users?.length ?? 0,
        itemCount:  context.read<PhonebookBloc>().state.phonebook?.data?.users?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              /// nevigate to details page
              // await allUserProvider.getPhonebookDetails(allUserProvider.responseAllUser?.data?.users?[index].id, allUserProvider.phonebookDetails, context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListTile(
                title: Text(context.read<PhonebookBloc>().state.phonebook?.data?.users?[index].name ?? ""),
                subtitle: Text(context.read<PhonebookBloc>().state.phonebook?.data?.users?[index].designation ?? ""),
                leading: ClipOval(
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    imageUrl: "${context.read<PhonebookBloc>().state.phonebook?.data?.users?[index].avatar}",
                    placeholder: (context, url) => Center(
                      child: Image.asset(
                          "assets/images/placeholder_image.png"),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    /// Dial
                    // FlutterPhoneDirectCaller.callNumber(allUserProvider.responseAllUser?.data?.users?[index].phone ?? "");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.phone,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
