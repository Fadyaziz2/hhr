import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/page/leave/view/content/leave_list_shimmer.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../../res/const.dart';
import 'daily_leave_status_widget.dart';

class DailyLeaveStatusContent extends StatelessWidget {
  const DailyLeaveStatusContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<DailyLeaveBloc,DailyLeaveState>(builder: (context,state){
     if(state.status == NetworkStatus.loading){
       return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
       child: LeaveListShimmer(),);

     }else if(state.status == NetworkStatus.success){
       return Column(
         children: [
           const Center(
               child: Text(
                 "Approved Leave",
                 style: TextStyle(
                     fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
               )),
           const SizedBox(
             height: 30,
           ),
            DailyLeaveStatusWidget(
             color: Colors.green,
             title: "Early Leave",
             count: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.approved?.earlyLeave.toString() ?? "",
           ),
           const SizedBox(height: 30,),
            DailyLeaveStatusWidget(
             color: Colors.green,
             title: "Late Arrive",
             count: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.approved?.lateArrive.toString() ?? "",
           ),
           const SizedBox(height: 10,),
           const Divider(thickness: 0.5,color: Colors.black12,),
           const SizedBox(height: 10,),
           const Center(
               child: Text(
                 "Rejected Leave",
                 style: TextStyle(
                     fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
               )),
           const SizedBox(
             height: 20,
           ),
           DailyLeaveStatusWidget(
             color: Colors.red,
             title: "Early Leave",
             count: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.rejected?.earlyLeave.toString(),
           ),
           const SizedBox(height: 30,),
           DailyLeaveStatusWidget(
             color: Colors.red,
             title: "Lave Arrive",
             count: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.rejected?.lateArrive.toString(),
           ),
           const SizedBox(height: 10,),
           const Divider(thickness: 0.5,color: Colors.black12,),
           const SizedBox(height: 10,),
           const Center(
               child: Text(
                 "Padding Leave",
                 style: TextStyle(
                     fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
               )),
           const SizedBox(
             height: 30,
           ),
           DailyLeaveStatusWidget(
             color: Colors.yellow.shade500,
             title: "Early Leave",
             count: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.pending?.earlyLeave.toString(),
           ),
           const SizedBox(height: 30,),
           DailyLeaveStatusWidget(
             color: Colors.yellow.shade500,
             title: "Late Arrive",
             count: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.pending?.lateArrive.toString(),
           ),
           const SizedBox(height: 10,),
         ],
       );
     }else if (state.status == NetworkStatus.failure) {
       return Center(
         child: Text(
           "Failed to load Leave list",
           style: TextStyle(
               color: colorPrimary.withOpacity(0.4),
               fontSize: 18,
               fontWeight: FontWeight.w500),
         ),
       );
     } else {
       return const SizedBox();
     }
   });
  }
}
