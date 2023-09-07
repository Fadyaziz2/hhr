import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/custom_radio_title.dart';
import 'package:onesthrm/page/profile/view/content/custom_text_field_with_title.dart';
import 'package:onesthrm/page/support/create_support_bloc/create_support_bloc.dart';
import 'package:onesthrm/page/support/create_support_bloc/create_support_event.dart';
import 'package:onesthrm/page/support/create_support_bloc/create_support_state.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';
import 'package:onesthrm/page/upload_file/view/upload_doc_content.dart';

import '../../../../../res/widgets/CustomButton.dart';

class CreateSupportListContent extends StatelessWidget {
  const CreateSupportListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BodyCreateSupport createSupport = BodyCreateSupport();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr("priority"),
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
                    value: BodyPrioritySupport(priorityName: 'High', priorityId: 10),
                    onChanged: (priorityValue) {
                      context.read<CreateSupportBloc>().add(GetPriority(bodyPrioritySupport: priorityValue!));
                      createSupport.priorityId = 10;
                    },
                    title: 'High',
                  ),
                ),
                Expanded(
                  child: CustomRadioTitle(
                    value: BodyPrioritySupport(priorityName: 'Medium', priorityId: 20),
                    onChanged: (priorityValue) {
                      context.read<CreateSupportBloc>().add(GetPriority(bodyPrioritySupport: priorityValue!));
                      createSupport.priorityId = 20;
                    },
                    title: 'Medium',
                  ),
                ),
                Expanded(
                  child: CustomRadioTitle(
                    value: BodyPrioritySupport(priorityName: 'Low', priorityId: 30),
                    onChanged: (priorityValue) {
                      context.read<CreateSupportBloc>().add(GetPriority(bodyPrioritySupport: priorityValue!));
                      createSupport.priorityId = 30;
                    },
                    title: 'Low',
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
            const SizedBox(
              height: 16,
            ),

            CustomButton(
              title: tr("submit"),
              padding: 0,
              clickButton: () {
                // provider.supportCreateApi(context);
                print(
                    "Subject : ${createSupport.subject} description : ${createSupport.description} priorityId : ${createSupport.priorityId} Preview URL : ${createSupport.previewURL}");
                context.read<CreateSupportBloc>().add(SubmitButton(bodyCreateSupport: createSupport));

              },
            ),
          ],
        ),
      ),
    );
  }
}
