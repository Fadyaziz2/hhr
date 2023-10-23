import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveCalender extends StatelessWidget {
  const LeaveCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("request_leave"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionColor: Colors.green,
            showNavigationArrow: true,
            toggleDaySelection: true,

          )
        ],
      ),
    );
  }
}
