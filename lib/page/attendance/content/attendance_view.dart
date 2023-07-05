import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance/content/show_current_location.dart';
import 'package:onesthrm/page/attendance/content/show_current_time.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';

class AttendanceView extends StatefulWidget {

  HomeBloc homeBloc;

   AttendanceView({Key? key,required this.homeBloc}) : super(key: key);

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
            // CheckInCheckOutButton(
            //   provider: provider,
            //   controller: controller,
            // ),
            // const SizedBox(
            //   height: 35,
            // ),
            //
            // /// Show Check In Check Out time
            // CheckInCheckOutTime(
            //   provider: provider,
            // ),
            const SizedBox(height: 70.0)
          ],
        ),
      ),
    );
  }
}
