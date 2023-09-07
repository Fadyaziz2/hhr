import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/profile/view/content/custom_radio_tile.dart';
import 'package:onesthrm/page/profile/view/content/custom_text_field_with_title.dart';
import 'package:onesthrm/page/support/view/create_support/bloc/create_support_bloc.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';
import 'package:onesthrm/page/upload_file/view/upload_content.dart';
import 'package:onesthrm/page/upload_file/view/upload_doc_content.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/widgets/CustomButton.dart';

import '../../../profile/view/content/custom_radio_title.dart';
import '../../../upload_file/bloc/upload_file_bloc.dart';
import '../../../upload_file/bloc/upload_file_event.dart';
import 'bloc/create_support_event.dart';

class CreateSupportPage extends StatelessWidget {
  const CreateSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BodyCreateSupport createSupport = BodyCreateSupport();
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => CreateSupportBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}')),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr("create_support_ticket"),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: appBarColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("priority"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),

                /// priority_id => [14 = high , 15 = medium , 16 = low' ]
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomRadioTitle(
                        value: BodyPrioritySupport(
                            priorityName: 'High', priorityId: 10),
                        onChanged: (priorityValue) {
                          if (kDebugMode) {
                            print("Radio $priorityValue");
                          }
                          context.read<CreateSupportBloc>().add(
                              GetPriority(bodyPrioritySupport: priorityValue!));
                          createSupport.priorityId = priorityValue.priorityId;
                          // personal.gender = genderValue;
                          // onPersonalUpdate(personal);
                          // bloc.add(OnGenderUpdate(gender: personal.gender!));
                        },
                        title: 'High',
                        initialData: "high",
                      ),
                    ),
                    Expanded(
                      child: CustomRadioTitle(
                        value: BodyPrioritySupport(
                            priorityName: 'Medium', priorityId: 20),
                        onChanged: (priorityValue) {
                          if (kDebugMode) {
                            print("Radio $priorityValue");
                          }
                          context.read<CreateSupportBloc>().add(
                              GetPriority(bodyPrioritySupport: priorityValue!));
                          // personal.gender= genderValue;
                          // onPersonalUpdate(personal);
                          // bloc.add(OnGenderUpdate(gender: personal.gender!));
                        },
                        title: 'Medium',
                        initialData: "medium",
                      ),
                    ),
                    Expanded(
                      child: CustomRadioTitle(
                        value: BodyPrioritySupport(
                            priorityName: 'Low', priorityId: 30),
                        onChanged: (priorityValue) {
                          if (kDebugMode) {
                            print("Radio $priorityValue");
                          }
                          context.read<CreateSupportBloc>().add(
                              GetPriority(bodyPrioritySupport: priorityValue!));
                          // personal.gender = genderValue;
                          // onPersonalUpdate(personal);
                          // bloc.add(OnGenderUpdate(gender: personal.gender!));
                        },
                        title: 'Low',
                        initialData: "low",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                  title: 'Subject',
                  hints: "Write Subject",
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    createSupport.subject = data;
                    // personal.phone = data;
                    // widget.onPersonalUpdate(personal);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                CustomTextField(
                  title: tr("what_support_do_you_need?"),
                  hints: "Write Description",
                  maxLine: 5,
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    createSupport.description = data;
                    // personal.phone = data;
                    // widget.onPersonalUpdate(personal);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                UploadDocContent(
                  onFileUpload: (FileUpload? data) {
                    if (kDebugMode) {
                      print(data?.previewUrl);
                    }
                    createSupport.previewURL = data?.previewUrl;
                  },
                  initialAvatar:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                ),
                const SizedBox(
                  height: 5,
                ),
                // SizedBox(
                //   child: provider.attachmentPath == null
                //       ? const SizedBox()
                //       : Image.file(
                //     provider.attachmentPath!,
                //     height: 60,
                //     width: 60,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                const SizedBox(
                  height: 16,
                ),

                CustomButton(
                  title: tr("submit"),
                  padding: 0,
                  clickButton: () {
                    // provider.supportCreateApi(context);
                    print(
                        "${createSupport.subject} description : ${createSupport.description} priorityId : ${createSupport.priorityId} Preview URL : ${createSupport.previewURL}");
                  context.read<CreateSupportBloc>().add(SubmitButton(bodyCreateSupport: createSupport));

                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
