import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../res/const.dart';
import '../content/visit_details_google_map.dart';

class VisitDetailsPage extends StatelessWidget {
  final int? visitID;
  const VisitDetailsPage({super.key,this.visitID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // NavUtil.navigateScreen(
          //     context,
          //     BlocProvider.value(
          //         value: context.read<VisitBloc>(),
          //         child: const CreateVisitPage()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title:  const Text(
          "Visit Details",
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text("November 17, 2023"),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(int.parse("0xFFFE8E63")),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    color: Color(int.parse("0xFFFE8E63")),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DottedBorder(
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    strokeWidth: 1,
                    child: const Text(
                      "Created",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Title Name",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Description",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: Text(
              tr("location"),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: const SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: VisitDetailsGoogleMap(),
                  )),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: Text(
              tr("phone_optional"),
              style:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 60.0,
              child: InkWell(
                onTap: () {
                  // provider.pickImage(context);
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: DottedBorder(
                          color: Colors.blue,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          strokeWidth: 1,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          )),
                    ),
                    // Expanded(
                    //   flex: 4,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     itemCount: provider.imageListSever?.length ?? 0,
                    //     itemBuilder: (BuildContext context, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: CachedNetworkImage(
                    //           height: 60,
                    //           width: 60,
                    //           fit: BoxFit.cover,
                    //           imageUrl: provider
                    //               .imageListSever?[index] ??
                    //               "https://www.w3schools.com/howto/img_avatar.png",
                    //           placeholder: (context, url) => Center(
                    //             child: Image.asset(
                    //                 "assets/images/placeholder_image.png"),
                    //           ),
                    //           errorWidget: (context, url, error) =>
                    //           const Icon(Icons.error),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 16),
            child: Text(
              tr("visit_notes"),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10),
                child: Row(
                  children:  [
                    Text(
                      tr("visit_notes"),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // NavUtil.replaceScreen(
                      //     context,
                      //     RescheduleVisit(
                      //       visitId: provider.visitDetails?.data?.id,
                      //     ));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text('Reschedule',
                        style: TextStyle(
                          color: colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // NavUtil.replaceScreen(
                      //     context,
                      //     VisitCancelScreen(
                      //       visitId: provider.visitDetails?.data?.id,
                      //     ));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(
                          color: colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }
}
