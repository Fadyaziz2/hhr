import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_event.dart';
import 'package:onesthrm/page/leave/bloc/leave_state.dart';
import 'package:onesthrm/page/leave/view/create_leave_request/create_leave_request.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveCalendar extends StatelessWidget {
  final int? leaveRequestTypeId;

  const LeaveCalendar({Key? key, this.leaveRequestTypeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => LeaveBloc(
          metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}")),
      child: BlocBuilder<LeaveBloc, LeaveState>(
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
                          CreateLeaveRequest(
                            leaveTypeId: leaveRequestTypeId,
                            starDate: state.startDate,
                            endDate: state.endDate,
                          ));
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    String? startDate;
    String? endDate;
    if (kDebugMode) {
      print(DateFormat('yyyy-MM-dd', 'en')
          .format(args.value.startDate)
          .toString());
      print(DateFormat('yyyy-MM-dd', 'en')
          .format(args.value.endDate ?? args.value.startDate)
          .toString());
    }
    startDate =
        DateFormat('yyyy-MM-dd', 'en').format(args.value.startDate).toString();
    endDate = DateFormat('yyyy-MM-dd', 'en')
        .format(args.value.endDate ?? args.value.startDate)
        .toString();

    // notifyListeners();
  }
}
