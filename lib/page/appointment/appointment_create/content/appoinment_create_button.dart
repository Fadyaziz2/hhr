import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appoinment_create_bloc.dart';

class AppoinmentCreateButton extends StatelessWidget {
  final AppoinmentCreatState? state;
  const AppoinmentCreateButton({
    super.key,
    required this.formKey,
    required this.appoinmentBody,
    this.state,
  });

  final GlobalKey<FormState> formKey;
  final AppoinmentBody appoinmentBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            appoinmentBody.date = state?.currentMonth;
            appoinmentBody.appoinmentStartDate = state?.startTime;
            appoinmentBody.appoinmentEndDate = state?.endTime;
            appoinmentBody.appoinmentWith = state?.selectedEmployee?.id;
            context
                .read<AppoinmentCreateBloc>()
                .add(CreateButton(context, appoinmentBody));
            print('data......${appoinmentBody.toJson()}');
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(tr("create"),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
      ),
    );
  }
}
