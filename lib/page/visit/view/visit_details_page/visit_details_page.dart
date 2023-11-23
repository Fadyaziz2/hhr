import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/visit/bloc/visit_bloc.dart';
import 'package:onesthrm/page/visit/view/content/visit_note_content.dart';
import 'package:onesthrm/page/visit/view/content/visit_photo_upload.dart';

import '../../../../res/widgets/custom_button.dart';
import '../../../home/view/content/home_content.dart';
import '../content/reschedule_cancel_button.dart';
import '../content/visit_app_bar_action.dart';
import '../content/visit_details_google_map.dart';
import '../content/visit_hearder.dart';

class VisitDetailsPage extends StatelessWidget {
  final int? visitID;

  const VisitDetailsPage({super.key, this.visitID});

  @override
  Widget build(BuildContext context) {
    context.read<VisitBloc>().add(VisitDetailsApi(
        visitId: visitID,
        latitude: locationServiceProvider.userLocation.latitude,
        longitude: locationServiceProvider.userLocation.longitude));

    late GoogleMapController mapController;
    BodyVisitCancel bodyStatusChange = BodyVisitCancel();
    return Scaffold(
        bottomNavigationBar: BlocBuilder<VisitBloc, VisitState>(
          builder: (context, state) {
            return Visibility(
              visible: state.visitDetailsResponse?.data?.nextStatus?.statusText
                      ?.isEmpty ==
                  false,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      title: state.visitDetailsResponse?.data?.nextStatus
                              ?.statusText ??
                          "",
                      padding: 16,
                      clickButton: () {
                        bodyStatusChange.visitId =
                            state.visitDetailsResponse?.data?.id;
                        bodyStatusChange.status = state
                            .visitDetailsResponse?.data?.nextStatus?.status;
                        bodyStatusChange.latitude = state.latitude.toString();
                        bodyStatusChange.longitude = state.longitude.toString();
                        context.read<VisitBloc>().add(VisitStatusApi(
                            context: context,
                            bodyVisitCancel: bodyStatusChange));
                      },
                    )),
              ),
            );
          },
        ),
        appBar: AppBar(
          title: const Text(
            "Visit Details",
          ),
          actions: [
            VisitAppBarAction(
              visitID: visitID,
            ),
          ],
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
                                    double.parse(data
                                            ?.schedules?[index].latitude
                                            .toString() ??
                                        ""),
                                    double.parse(data
                                            ?.schedules?[index].longitude
                                            .toString() ??
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
              height: 20,
            ),
          ],
        ));
  }
}
