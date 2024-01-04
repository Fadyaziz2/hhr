import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/select_employee/content/get_employee_content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/widgets/device_util.dart';

class SelectEmployeePage extends StatelessWidget {
  const SelectEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
      create: (_) => PhoneBookBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}', companyUrl: baseUrl))
        ..add(PhoneBookLoadRequest()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 :55),
          child: AppBar(
            iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30,   color: Colors.white),
            title:  Text('Select Employee',style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),),
            backgroundColor: mainColor,
          ),
        ),
        body: const GetEmployeeContent(),
      ),
    );
  }
}
