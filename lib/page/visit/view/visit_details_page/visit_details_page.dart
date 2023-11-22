import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/visit/bloc/visit_bloc.dart';
import 'package:onesthrm/page/visit/view/content/visit_note_content.dart';
import 'package:onesthrm/page/visit/view/content/visit_photo_upload.dart';

import '../content/reschedule_cancel_button.dart';
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
        body: ListView(
          children: [
            /// Visit Header Part .....
            const VisitHeader(),

            /// Visit Google Map Part .....
            VisitDetailsGoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),

            /// Visit Photo Upload Part .....
            const VisitPhoneUpload(),

            /// Visit Schedule List Part .....
            BlocBuilder<VisitBloc, VisitState>(builder: (context, state) {
              VisitDetailsResponse? data = state.visitDetailsResponse?.data;
              return ListView.separated(
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
                                        data?.schedules?[index].latitude ?? ""),
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
              );
            }),

            /// Visit Note Part .....
            VisitNoteContent(visitID: visitID),

            /// Visit ReSchedule and Cancel Button Part
            RescheduleCancelButton(
              visitId: visitID,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
