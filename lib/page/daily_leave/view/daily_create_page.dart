import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';

import '../../../res/widgets/custom_button.dart';

class DailyCreatePage extends StatelessWidget {
  const DailyCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final bloc = context.watch<DailyLeaveBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("daily_leave")),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            title: "Apply",
            padding: 16,
            clickButton: () {
              context.read<DailyLeaveBloc>().add(ApplyLeave(userId: user!.user!.id!, context: context));
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
          BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
            builder: (BuildContext context, state) {
              return Column(
                children: [
                  ...List.generate(
                      bloc.leave?.length ?? 0,
                          (index) => Card(
                        margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: RadioListTile(
                            title: Text(bloc.leave?[index].title ?? ''),
                            value: bloc.leave?[index],
                            groupValue: state.leaveTypeModel,
                            onChanged: (value) {
                              context
                                  .read<DailyLeaveBloc>()
                                  .add(SelectLeaveType(leaveTypeModel: value!));
                            }),
                      )),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: ListTile(
                      onTap: () {
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                          if (value != null) {
                            var selectedTime = value.format(context);
                            context.read<DailyLeaveBloc>().add(SelectApproxTime(selectedTime));
                          }
                        });
                      },
                      leading: const Icon(Icons.access_time_outlined),
                      title: Text(state.approxTime ?? 'Time'),
                      trailing: const Icon(Icons.keyboard_arrow_down_sharp),
                    ),
                  ),
                ],
              );
            }
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: bloc.reasonTextController,
              maxLines: 6,
              validator: (val) => val!.isEmpty ? "Reason can't be empty" : null,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                  hintText: 'Write Reason',
                  hintStyle: TextStyle(fontSize: 12),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
