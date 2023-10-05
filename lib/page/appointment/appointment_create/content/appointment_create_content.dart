import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appointment_create_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appointment_time_cart.dart';
import 'package:onesthrm/page/appointment/appointment_create/view/appointment_create_screen.dart';

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
        buildTextTitle(tr("title*")),

        ///title field:-------------------------
        buildTextFormField(
          onChanged: (data) {
            appointmentBody.title = data;
          },
          labelTitle: tr("enter_title"),
        ),
        const SizedBox(
          height: 25,
        ),

        ///Description field:-------------------------
        buildTextTitle(tr("description")),
        TextFormField(
          onChanged: (data) {
            appointmentBody.description = data;
          },
          // controller: provider.descriptionController,
          maxLines: 3,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF3F9FE).withOpacity(1),
            hintText: "Enter Description",
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),

        ///Date picker field:-------------------------
        buildTextTitle(tr("date_schedule")),
        Card(
          child: InkWell(
            onTap: () {
              context
                  .read<AppointmentCreateBloc>()
                  .add(SelectDatePicker(context));
            },
            // provider.selectDate(context),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.currentMonth ?? 'Select Date'),
                  // provider.monthYear ?? tr
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

        ///Time picker field:-------------------------
        ///Start and End time
        AppointmentTimeCart(
          state: state,
        ),
        const SizedBox(
          height: 16,
        ),
        buildTextTitle(tr("Location*")),
        buildTextFormField(
          onChanged: (data) {
            appointmentBody.location = data;
          },
          labelTitle: tr("enter_location"),
          // controller: provider.locationController
        ),
      ],
    );
  }
}
