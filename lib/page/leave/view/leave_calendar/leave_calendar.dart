import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/leave/view/create_leave_request/create_leave_request.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveCalendar extends StatelessWidget {
  const LeaveCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ),
          CustomButton(
              title: "Next",
              padding: 16,
              clickButton: () {
                NavUtil.navigateScreen(context, const CreateLeaveRequest());
              })
        ],
      ),
    );
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (kDebugMode) {
      print(DateFormat('yyyy-MM-dd', 'en')
          .format(args.value.startDate)
          .toString());
      print(DateFormat('yyyy-MM-dd', 'en')
          .format(args.value.endDate ?? args.value.startDate)
          .toString());
    }
    // startDate =
    //     DateFormat('yyyy-MM-dd','en').format(args.value.startDate).toString();
    // endDate = DateFormat('yyyy-MM-dd','en')
    //     .format(args.value.endDate ?? args.value.startDate)
    //     .toString();
    // notifyListeners();
  }
}
