import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../../res/const.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../../profile/view/content/custom_text_field_with_title.dart';
import '../../bloc/visit_bloc.dart';

class VisitReschedule extends StatelessWidget {
  final int? visitId;
  const VisitReschedule({super.key,this.visitId});

  @override
  Widget build(BuildContext context) {
    BodyCreateSchedule bodyCreateSchedule =  BodyCreateSchedule();

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<VisitBloc, VisitState>(
              builder: (context, state) {
                return CustomButton(
                  title: "Create Reschedule",
                  padding: 16,
                  isLoading: state.status == NetworkStatus.loading,
                  clickButton: () {
                    if(state.currentDate != null) {
                      bodyCreateSchedule.date = state.currentDate;
                      bodyCreateSchedule.visitId = visitId;
                      bodyCreateSchedule.latitude = state.latitude.toString();
                      bodyCreateSchedule.longitude = state.longitude.toString();

                      context.read<VisitBloc>().add(CreateRescheduleEvent(
                          bodyCreateSchedule: bodyCreateSchedule,
                          context: context));
                    }else {
                      Fluttertoast.showToast(msg: "Date filed can't be Empty");
                    }
                  },
                );
              },
            )),
      ),
      appBar: AppBar(
        title: Text(tr("reschedule_visit")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
              child: Text(
                tr("date*"),
                style: const TextStyle(
                    color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<VisitBloc, VisitState>(
                builder: (BuildContext context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<VisitBloc>().add(SelectDatePickerEvent(context));
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.currentDate?.isEmpty == true
                                ? "Selected Date"
                                : state.currentDate ?? "Selected Date",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.date_range_outlined)
                        ],
                      ),
                    ),
                  ),
                  state.isDateEnable == true
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            "You must Select a visit date",
                            style: TextStyle(color: colorDeepRed, fontSize: 12),
                          ),
                        )
                      : const SizedBox()
                ],
              );
            }),
            const SizedBox(height: 10,),
            CustomTextField(
              title: tr("Note (Optional)"),
              hints: "write_note".tr(),
              maxLine: 5,
              onData: (data) {
                if (kDebugMode) {
                  print(data);
                }
                bodyCreateSchedule.note = data;
              },
            ),
          ],
        ),
      ),
    );
  }
}
