import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../../profile/view/content/custom_text_field_with_title.dart';
import '../../bloc/visit_bloc.dart';

class VisitCancelPage extends StatelessWidget {
  const VisitCancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
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
                    clickButton: () {
                      if (formKey.currentState!.validate() &&
                          state.status == NetworkStatus.success) {
                        // bodyCreateSchedule.date = state.currentDate;
                        // bodyCreateSchedule.visitId = visitId;
                        // bodyCreateSchedule.latitude = "23.815877934750823";
                        // bodyCreateSchedule.longitude = "90.36617788667017";
                        //
                        // context.read<VisitBloc>().add(CreateRescheduleApi(
                        //     bodyCreateSchedule: bodyCreateSchedule,
                        //     context: context));
                      }
                    },
                  );
                },
              )),
        ),
        appBar: AppBar(
          title:  Text(
              tr("why_do_you_want_to_cancel_the_visit")
          ),
        ),
        body: CustomTextField(
          title: tr("Note (Optional)"),
          hints: "write_a_cancellation_note".tr(),
          maxLine: 5,
          onData: (data) {
            if (kDebugMode) {
              print(data);
            }
            // bodyCreateSchedule.note = data;
          },
        ),
      ),
    );
  }
}
