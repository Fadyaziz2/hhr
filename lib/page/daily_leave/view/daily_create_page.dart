import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../res/widgets/custom_button.dart';
import '../../profile/view/content/custom_text_field_with_title.dart';

class DailyCreatePage extends StatelessWidget {
  const DailyCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("daily_leave")),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.access_time_outlined),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            title: "Apply",
            padding: 16,
            clickButton: () {
              // NavUtil.replaceScreen(
              //     context, BlocProvider.value(
              //     value: context.read<LeaveBloc>(),
              //     child: LeaveCalendar(leaveRequestTypeId: state.selectedRequestType?.id)));
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
                title: "",
                hints: "Write Reason",
                errorMsg: "Response can't be empty",
                maxLine: 7,
                onData: (data) {
                  // bodyCreateLeave.reason = data;
                }),
          ),

        ],
      ),
    );
  }
}
