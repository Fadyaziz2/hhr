import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../res/const.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../home/bloc/home_bloc.dart';
import '../home/view/content/home_content.dart';

class AppPermissionPage extends StatefulWidget {
  const AppPermissionPage({super.key});

  @override
  State<AppPermissionPage> createState() => _AppPermissionPageState();

  static Route route(){
    return MaterialPageRoute(builder: (_) => const AppPermissionPage());
  }

}

class _AppPermissionPageState extends State<AppPermissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [colorPrimary.withOpacity(0.7), colorPrimary])),
        child: ListView(
          children: [
            const SizedBox(height: 32.0),
            const Text('HRM App collects location data to enable below features even when the app is closed or not in use',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
            const SizedBox(height: 32.0,),
            const ListTile(
              leading: Icon(Icons.add_location, color: Colors.white, size: 30.0,),
              title: Text('1.Location data to enable  employee attendance and visit feature',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            const SizedBox(height: 16.0),
            const ListTile(leading: Icon(Icons.local_gas_station_sharp, color: Colors.white, size: 30.0),
              title: Text('2.Find distance between employee and office position for accurate daily attendance',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            const SizedBox(height: 16.0),
            const ListTile(
              leading: Icon(Icons.local_gas_station_sharp, color: Colors.white, size: 30.0,),
              title: Text('3.Allows the employer to track employee, when his/her employee is on the way to field job',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            const SizedBox(height: 16.0),
            const ListTile(
              leading: Icon(
                Icons.local_gas_station_sharp, color: Colors.white, size: 30.0,),
              title: Text('4.Increase the efficiency and smoothness of the attendance',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            const ListTile(
              title: Text('You can change this later in the settings app',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(OnSwitchPressed(user: context.read<AuthenticationBloc>().state.data?.user,
                    locationProvider: locationServiceProvider));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text(tr("next"),
                  style: const TextStyle(color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}
