import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/visit/bloc/visit_bloc.dart';

import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../profile/view/content/custom_text_field_with_title.dart';

class CreateVisitPage extends StatelessWidget {
  const CreateVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    BodyCreateVisit bodyCreateVisit = BodyCreateVisit();
    final formKey = GlobalKey<FormState>();
    bool isDateEnable = false;
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  return CustomButton(
                    title: "Create Visit",
                    padding: 16,
                    clickButton: () {
                      state.currentDate == null
                          ? isDateEnable = false
                          : isDateEnable = true; // todo
                      if (formKey.currentState!.validate() &&
                          state.status == NetworkStatus.success) {
                        bodyCreateVisit.userId = user?.user?.id;
                        bodyCreateVisit.date = state.currentDate;
                        context.read<VisitBloc>().add(CreateVisitEvent(
                            bodyCreateVisit: bodyCreateVisit,
                            context: context));
                      }
                    },
                  );
                },
              )),
        ),
        appBar: AppBar(
          title: Text(
            tr("create_visit"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                  child: Text(
                    tr("employee"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      user?.user?.name ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user?.user?.email ?? "",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: "${user?.user?.avatar}",
                        placeholder: (context, url) => Center(
                          child: Image.asset(
                              "assets/images/placeholder_image.png"),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                  child: Text(
                    tr("date*"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                BlocBuilder<VisitBloc, VisitState>(
                    builder: (BuildContext context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<VisitBloc>()
                              .add(SelectDatePicker(context));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.currentDate ?? "Selected Date",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.date_range_outlined)
                            ],
                          ),
                        ),
                      ),
                      isDateEnable == false
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Text(
                                "You must Select a visit date",
                                style: TextStyle(
                                    color: Color(0xFFD53A3F), fontSize: 12),
                              ),
                            )
                    ],
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  title: 'title*'.tr(),
                  hints: tr("give_a_title_to_your_visit"),
                  errorMsg: "Field cannot be empty",
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    bodyCreateVisit.title = data;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  title: tr("description_optional"),
                  hints: "write_a_note".tr(),
                  maxLine: 5,
                  onData: (data) {
                    if (kDebugMode) {
                      print(data);
                    }
                    bodyCreateVisit.description = data;
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
