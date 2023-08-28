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
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/widgets/CustomButton.dart';

class CreateSupportPage extends StatelessWidget {
  const CreateSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => CreateSupportBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}')),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomRadioTile(
                        onChanged: (genderValue) {
                          if (kDebugMode) {
                            print("Radio $genderValue");
                          }
                          // personal.gender = genderValue;
                          // onPersonalUpdate(personal);
                          // bloc.add(OnGenderUpdate(gender: personal.gender!));
                        },
                        title: 'High',
                        initialData: "male",
                      ),
                    ),
                    Expanded(
                      child: CustomRadioTile(
                        onChanged: (genderValue) {
                          if (kDebugMode) {
                            print("Radio $genderValue");
                          }
                          // personal.gender = genderValue;
                          // onPersonalUpdate(personal);
                          // bloc.add(OnGenderUpdate(gender: personal.gender!));
                        },
                        title: 'Medium',
                        initialData: "female",
                      ),
                    ),
                    Expanded(
                      child: CustomRadioTile(
                        onChanged: (genderValue) {
                          if (kDebugMode) {
                            print("Radio $genderValue");
                          }
                          // personal.gender = genderValue;
                          // onPersonalUpdate(personal);
                          // bloc.add(OnGenderUpdate(gender: personal.gender!));
                        },
                        title: 'Low',
                        initialData: "unisex",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                  title: 'phone',
                  hints: "Write Subject",
                  onData: (data) {
                    print(data);
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
                    print(data);
                    // personal.phone = data;
                    // widget.onPersonalUpdate(personal);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    // provider.pickAttachmentImage(context);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 0.0,
                      ),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: DottedBorder(
                      color: const Color(0xffC7C7C7),
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      strokeWidth: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Icon(
                            Icons.upload_file,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            tr("add_file"),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
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
