import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import '../../res/widgets/custom_button.dart';
import '../home/models/attendance_body.dart';
import '../profile/view/content/custom_text_field_with_title.dart';

class AttendanceReason extends StatelessWidget {
  const AttendanceReason({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceBody body = AttendanceBody();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: Colors.grey[100],
              borderRadius: BorderRadius.circular(0)),
          child: Padding(padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                title: "Submit Reason",
                padding: 16,
                clickButton: () {
                  if(formKey.currentState!.validate() ){
                    Fluttertoast.showToast(msg: "Reason added successfully");
                    context.read<AttendanceBloc>().add(ReasonEvent(reasonData: body.reason!));
                    Navigator.pop(context);
                  }
                },
              )),
        ),
        appBar: AppBar(
          title: const Text("Attendance Reason")),
        body: Padding(padding: const EdgeInsets.all(12.0),
          child: CustomTextField(
            title: "Give a reason",
            hints: "Write a reason here",
            maxLine: 5,
            errorMsg: "Give a reason field cannot be empty",
            onData: (data) {
              body.reason = data;
            },
          ),
        ),
      ),
    );
  }
}
