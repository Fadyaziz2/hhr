import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appointment_create_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appointment_time_cart.dart';
import 'package:onesthrm/res/common_text_widget.dart';

class AppointmentCreateContent extends StatelessWidget {
  final AppointmentCreateState? state;
  const AppointmentCreateContent(
      {super.key, required this.appointmentBody, this.state});

  final AppointmentBody appointmentBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFiledWithTitle(
          title: "Title",
          labelText: 'enter_title'.tr(),
          onChanged: (data) {
            appointmentBody.title = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        CommonTextFiledWithTitle(
          title: "description",
          labelText: "Enter Text",
          onChanged: (data) {
            appointmentBody.description = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            "date_schedule",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              context
                  .read<AppointmentCreateBloc>()
                  .add(SelectDatePicker(context));
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.currentMonth ?? 'Select Date'),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        AppointmentTimeCart(
          state: state,
        ),
        const SizedBox(
          height: 16,
        ),
        CommonTextFiledWithTitle(
          title: "Location".tr(),
          labelText: 'enter_location'.tr(),
          onChanged: (data) {
            appointmentBody.location = data;
          },
        ),
      ],
    );
  }
}
