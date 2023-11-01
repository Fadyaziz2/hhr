import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/view/create_leave_request/create_leave_request.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveCalendar extends StatelessWidget {
  final int? leaveRequestTypeId;

  const LeaveCalendar({Key? key, this.leaveRequestTypeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr("request_leave")),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionColor: Colors.green,
                showNavigationArrow: true,
                toggleDaySelection: false,
                enablePastDates: false,
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs args) {
                  String? startDate = DateFormat('yyyy-MM-dd', 'en')
                      .format(args.value.startDate)
                      .toString();
                  String? endDate = DateFormat('yyyy-MM-dd', 'en')
                      .format(args.value.endDate ?? args.value.startDate)
                      .toString();

                  context
                      .read<LeaveBloc>()
                      .add(SelectedCalendar(startDate, endDate));
                },
              ),
              CustomButton(
                  title: "Next",
                  padding: 16,
                  clickButton: () {
                    NavUtil.replaceScreen(
                        context,
                        BlocProvider.value(
                          value: context.read<LeaveBloc>(),
                          child: CreateLeaveRequest(
                            leaveTypeId: leaveRequestTypeId,
                            starDate: state.startDate,
                            endDate: state.endDate,
                          ),
                        ));
                  })
            ],
          ),
        );
      },
    );
  }
}
