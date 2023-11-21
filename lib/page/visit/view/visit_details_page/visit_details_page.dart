import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/visit/bloc/visit_bloc.dart';
import 'package:onesthrm/page/visit/view/content/visit_note_content.dart';

import '../../../../res/const.dart';
import '../content/visit_details_google_map.dart';
import '../content/visit_hearder.dart';

class VisitDetailsPage extends StatelessWidget {
  final int? visitID;

  const VisitDetailsPage({super.key, this.visitID});

  @override
  Widget build(BuildContext context) {
    context.read<VisitBloc>().add(VisitDetailsApi(visitID));
    late GoogleMapController mapController;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Visit Details",
          ),
        ),
        body: BlocBuilder<VisitBloc, VisitState>(
          builder: (context, state) {
            VisitDetailsResponse? data = state.visitDetailsResponse?.data;
            return ListView(
              children: [
                const VisitHeader(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Text(
                    tr("location"),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: VisitDetailsGoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  child: Text(
                    tr("phone_optional"),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data?.schedules?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        context.read<VisitBloc>().add(
                              VisitGoToPosition(
                                  latLng: LatLng(
                                      double.parse(
                                          data?.schedules?[index].latitude ??
                                              ""),
                                      double.parse(
                                          data?.schedules?[index].longitude ??
                                              "")),
                                  controller: mapController),
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data?.schedules?[index].title ?? "",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            state.locationListServer?.isNotEmpty == true
                                ? Text(state.locationListServer?[index] ??
                                    tr("loading"))
                                : Text(tr("loading")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data?.schedules?[index].dateTime ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
                const VisitNoteContent(),
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
            );
          },
        ));
  }
}
