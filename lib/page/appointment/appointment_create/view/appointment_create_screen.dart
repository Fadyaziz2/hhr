import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appoinment_create_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appoinment_create_button.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appoinment_create_content.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appoinment_time_cart.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/appoinment_with_cart.dart';
import 'package:onesthrm/page/appointment/appointment_create/content/attachment_content.dart';
import 'package:onesthrm/page/appointment/get_employee/view/get_employee.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/upload_file/view/upload_doc_content.dart';
import 'package:onesthrm/res/enum.dart';

class AppointmentCreateScreen extends StatefulWidget {
  final String? navigation;

  const AppointmentCreateScreen({Key? key, this.id, this.navigation})
      : super(key: key);

  ///user Id
  final int? id;

  @override
  State<AppointmentCreateScreen> createState() =>
      _AppointmentCreateScreenState();
}

class _AppointmentCreateScreenState extends State<AppointmentCreateScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AppoinmentBody appoinmentBody = AppoinmentBody();
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => AppoinmentCreateBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(LoadAppoinmentCreateData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr("appointment_create")),
        ),
        body: BlocBuilder<AppoinmentCreateBloc, AppoinmentCreatState>(
          builder: (context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == NetworkStatus.success) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppoinmentCreateContent(
                            state: state, appoinmentBody: appoinmentBody),
                        AppoinmentWithCart(state: state),
                        const SizedBox(
                          height: 25,
                        ),
                        AttachmentContent(appoinmentBody: appoinmentBody),
                        const SizedBox(
                          height: 6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                appoinmentBody.date = state.currentMonth;
                                appoinmentBody.appoinmentStartDate =
                                    state.startTime;
                                appoinmentBody.appoinmentEndDate =
                                    state.endTime;
                                appoinmentBody.appoinmentWith =
                                    state.selectedEmployee?.id;
                                context
                                    .read<AppoinmentCreateBloc>()
                                    .add(CreateButton(context, appoinmentBody));
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state.status == NetworkStatus.failure) {
              return const Center(
                  child: Text('Failed to load Appionment list'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Padding buildTextTitle(title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Text(
      title,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}

TextFormField buildTextFormField({
  controller,
  labelTitle,
  onchanged,
}) {
  return TextFormField(
    onChanged: onchanged,
    controller: controller,
    decoration: InputDecoration(
      labelText: "$labelTitle",
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return tr("this_field_is_required");
      }
      return null;
    },
  );
}
