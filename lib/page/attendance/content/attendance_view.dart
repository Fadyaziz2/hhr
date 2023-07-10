import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/content/show_current_location.dart';
import 'package:onesthrm/page/attendance/content/show_current_time.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import 'animated_circular_button.dart';
import 'check_in_check_out_button.dart';
import 'check_in_check_out_time.dart';

class AttendanceView extends StatefulWidget {

   final HomeBloc homeBloc;

   const AttendanceView({Key? key,required this.homeBloc}) : super(key: key);

  @override
  State<AttendanceView> createState() => _AttendanceState();
}

class _AttendanceState extends State<AttendanceView> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        animationBehavior: AnimationBehavior.preserve);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;
    final homeData = widget.homeBloc.state.dashboardModel;

    return BlocBuilder<AttendanceBloc,AttendanceState>(
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Attendance'),
          ),
          body: Center(
            child: ListView(
              children:  [
                /// Show Current Location and Remote mode ......
                if(homeData != null)
                  ShowCurrentLocation(homeData: homeData,),

                /// Show Current time .......
                if(homeData != null)
                  ShowCurrentTime(homeData: homeData),

                // /// Check In Check Out Button .......
                // if(homeData != null)
                //   CheckInCheckOutButton(homeData: homeData),
                if(homeData != null)
                 AnimatedCircularButton(onComplete: (){
                   context.read<AttendanceBloc>().add(OnAttendance(homeData: homeData));
                 },),

                const SizedBox(
                  height: 35,
                ),

                /// Show Check In Check Out time
                if(homeData != null)
                  CheckInCheckOutTime(homeData: homeData,),
                const SizedBox(height: 70.0)
              ],
            ),
          ),
        );
      },
    );
  }
}
