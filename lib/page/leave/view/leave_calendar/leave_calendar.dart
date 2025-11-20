import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/view/create_leave_request/create_leave_request.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/custom_button.dart';
import 'package:onesthrm/res/widgets/device_util.dart';
class LeaveCalendar extends StatefulWidget {
  final int? leaveRequestTypeId;

  const LeaveCalendar({super.key, this.leaveRequestTypeId});

  @override
  State<LeaveCalendar> createState() => _LeaveCalendarState();
}

class _LeaveCalendarState extends State<LeaveCalendar> {
  DateTimeRange? _selectedRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final now = DateTime.now();
    final initialRange = _selectedRange ??
        DateTimeRange(start: now, end: now.add(const Duration(days: 1)));

    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDateRange: initialRange,
    );

    if (pickedRange != null) {
      setState(() {
        _selectedRange = pickedRange;
      });

      final startDate =
          DateFormat('yyyy-MM-dd', 'en').format(pickedRange.start).toString();
      final endDate =
          DateFormat('yyyy-MM-dd', 'en').format(pickedRange.end).toString();

      // ignore: use_build_context_synchronously
      context.read<LeaveBloc>().add(SelectedCalendar(startDate, endDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 50),
            child: AppBar(
              iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30,   color: Colors.white),
              title: Text(tr("request_leave"),style: TextStyle(fontSize: 16.sp),),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDateRange(context),
                      child: Text(tr('select_date')),
                    ),
                    const SizedBox(height: 12),
                    if (_selectedRange != null)
                      Text(
                        '${DateFormat('yyyy-MM-dd', 'en').format(_selectedRange!.start)}  -  ${DateFormat('yyyy-MM-dd', 'en').format(_selectedRange!.end)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    else
                      Text(
                        tr('select_date'),
                        style: const TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                  title: "next".tr(),
                  padding: 16,
                  clickButton: () {
                    if (state.startDate == null) {
                      Fluttertoast.showToast(msg: "Please select Date");
                    } else {
                      NavUtil.replaceScreen(context, BlocProvider.value(value: context.read<LeaveBloc>(),
                            child: CreateLeaveRequest(leaveTypeId: widget.leaveRequestTypeId, starDate: state.startDate, endDate: state.endDate,)));
                    }
                  })
            ],
          ),
        );
      },
    );
  }
}
