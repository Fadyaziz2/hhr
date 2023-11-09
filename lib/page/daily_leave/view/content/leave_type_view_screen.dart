import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';

class LeaveTypeViewScreen extends StatelessWidget {
  final LeaveListDatum? data;
  final DailyLeaveState? state;
  const LeaveTypeViewScreen({super.key, this.data, this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.leaveType ?? ''),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: ,
          // )
        ],
      ),
    );
  }
}
