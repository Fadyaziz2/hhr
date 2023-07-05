import 'package:flutter/material.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import '../content/attendance_view.dart';

class AttendancePage extends StatelessWidget {

  final HomeBloc homeBloc;

  const AttendancePage({Key? key,required this.homeBloc}) : super(key: key);

  static Route route({required HomeBloc homeBloc}){
    return MaterialPageRoute(builder: (_) =>  AttendancePage(homeBloc: homeBloc,));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AttendanceView(homeBloc: homeBloc,),
    );
  }
}
