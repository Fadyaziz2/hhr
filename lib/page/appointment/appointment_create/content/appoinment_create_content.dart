import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appoinment_create_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appoinment_time_cart.dart';
import 'package:onesthrm/page/appointment/appointment_create/view/appointment_create_screen.dart';

class AppoinmentCreateContent extends StatelessWidget {
  final AppoinmentCreatState? state;
  const AppoinmentCreateContent(
      {super.key, required this.appoinmentBody, this.state});

  final AppoinmentBody appoinmentBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextTitle(tr("title*")),

        ///title field:-------------------------
        buildTextFormField(
          onchanged: (data) {
            appoinmentBody.title = data;
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
            appoinmentBody.description = data;
          },
          // controller: provider.descriptionController,
          maxLines: 3,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: "Enter Description",
            border: OutlineInputBorder(
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
                  .read<AppoinmentCreateBloc>()
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
        AppoinmentTimeCart(
          state: state,
        ),
        const SizedBox(
          height: 16,
        ),
        buildTextTitle(tr("Location*")),
        buildTextFormField(
          onchanged: (data) {
            appoinmentBody.location = data;
          },
          labelTitle: tr("enter_location"),
          // controller: provider.locationController
        ),
      ],
    );
  }
}
