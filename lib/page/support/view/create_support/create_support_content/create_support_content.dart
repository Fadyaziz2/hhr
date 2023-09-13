import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/profile/view/content/custom_radio_title.dart';
import 'package:onesthrm/page/profile/view/content/custom_text_field_with_title.dart';
import 'package:onesthrm/page/support/support_bloc/support_bloc.dart';
import 'package:onesthrm/page/upload_file/view/upload_doc_content.dart';

import '../../../../../res/widgets/CustomButton.dart';

class CreateSupportListContent extends StatelessWidget {
  const CreateSupportListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BodyCreateSupport createSupport = BodyCreateSupport();

    return BlocBuilder<SupportBloc, SupportState>(
      builder: (context, state) {
        return SingleChildScrollView(
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
                        groupValue: state.bodyPrioritySupport,
                        value: BodyPrioritySupport(
                            priorityName: 'High', priorityId: 14),
                        onChanged: (priorityValue) {
                          context.read<SupportBloc>().add(
                              GetPriority(bodyPrioritySupport: priorityValue!));
                          createSupport.priorityId = 14;
                        },
                        title: 'High',
                      ),
                    ),
                    Expanded(
                      child: CustomRadioTitle(
                        groupValue: state.bodyPrioritySupport,
                        value: BodyPrioritySupport(
                            priorityName: 'Medium', priorityId: 15),
                        onChanged: (priorityValue) {
                          context.read<SupportBloc>().add(
                              GetPriority(bodyPrioritySupport: priorityValue!));
                          createSupport.priorityId = 15;
                        },
                        title: 'Medium',
                      ),
                    ),
                    Expanded(
                      child: CustomRadioTitle(
                        groupValue: state.bodyPrioritySupport,
                        value: BodyPrioritySupport(
                            priorityName: 'Low', priorityId: 16),
                        onChanged: (priorityValue) {
                          context.read<SupportBloc>().add(
                              GetPriority(bodyPrioritySupport: priorityValue!));
                          createSupport.priorityId = 16;
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
                      print(data?.fileId);
                    }
                    createSupport.previewId = data?.fileId;
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
                    context.read<SupportBloc>().add(SubmitButton(
                        bodyCreateSupport: createSupport, context: context));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
