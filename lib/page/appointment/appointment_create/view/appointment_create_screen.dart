import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appoinment_create_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/model/appoinment_body_model.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/upload_file/view/upload_doc_content.dart';
import 'package:onesthrm/res/enum.dart';

class AppointmentCreateScreen extends StatelessWidget {
  final String? navigation;

  const AppointmentCreateScreen({Key? key, this.id, this.navigation})
      : super(key: key);

  ///user Id
  final int? id;

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
                        buildTextTitle(tr("title*")),

                        ///title field:-------------------------
                        buildTextFormField(
                          onchanged: (data) {
                            appoinmentBody.title = data;
                          },
                          labelTitle: tr("enter_title"),
                          // controller: provider.titleController
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state.currentMonth ?? 'Select Date'),
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr("start_time"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<AppoinmentCreateBloc>()
                                            .add(SelectStartTime(
                                              context,
                                            ));
                                      },

                                      // provider.showTime(context, 0),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(state.startTime ??
                                                tr("start_time")),
                                            // provider.startTime ??
                                            // tr("start_time")),
                                            const Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr("end_time"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<AppoinmentCreateBloc>()
                                            .add(SelectEndTime(
                                              context,
                                            ));
                                      },
                                      // provider.showTime(context, 1),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(state.endTime ??
                                                // provider.endTime ??
                                                tr("end_time")),
                                            const Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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

                        ///if user come from appointment List page
                        ///then id will be null
                        id == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  buildTextTitle(tr("appointment_with")),
                                  Card(
                                    child: ListTile(
                                      onTap: () {},
                                      // provider.getAllUserData(context),
                                      title: Text(
                                          // provider.allUserData?.name! ??
                                          tr("add_a_Substitute")),
                                      subtitle: Text(
                                          // provider.allUserData?.designation! ??
                                          tr("add_a_Designation")),
                                      leading: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                      ),
                                      trailing: const Icon(Icons.edit),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          tr("attachment"),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        UploadDocContent(
                          onFileUpload: (FileUpload? data) {
                            if (kDebugMode) {
                              print(data?.previewUrl);
                            }
                            appoinmentBody.attachmentFile = data?.previewUrl;
                          },
                          initialAvatar:
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.green,
                        //       style: BorderStyle.solid,
                        //       width: 0.0,
                        //     ),
                        //     color: Colors.grey[200],
                        //     borderRadius: BorderRadius.circular(3.0),
                        //   ),
                        //   child: InkWell(
                        //     onTap: () {},
                        //     // provider.pickAttachmentImage(context),
                        //     child: DottedBorder(
                        //       color: const Color(0xffC7C7C7),
                        //       borderType: BorderType.RRect,
                        //       radius: const Radius.circular(3),
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 10, vertical: 16),
                        //       strokeWidth: 2,
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           const Icon(
                        //             Icons.upload_file,
                        //             color: Colors.grey,
                        //           ),
                        //           const SizedBox(
                        //             width: 8,
                        //           ),
                        //           Text(
                        //             tr("upload_your_file"),
                        //             style: const TextStyle(
                        //                 color: Colors.grey,
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 6,
                        ),
                        // provider.attachmentPath != null
                        // ?
                        // Image.file(
                        //     provider.attachmentPath!,
                        //     height: 60,
                        //     width: 60,
                        //     fit: BoxFit.cover,
                        //   ),
                        // : const SizedBox(),
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
                                appoinmentBody.appoinmentWith = 3;
                                appoinmentBody.attachmentFile =
                                    "https://s3.envato.com/files/447658025/8mayEnvato_Banner-sm.png";
                                context
                                    .read<AppoinmentCreateBloc>()
                                    .add(CreateButton(context, appoinmentBody));
                                print('data......${appoinmentBody.toJson()}');

                                ///id is for user id
                                // await provider.setCreateAppointment(context, id);
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
                        ),
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
