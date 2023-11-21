import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/visit/bloc/visit_bloc.dart';

import '../../../../res/widgets/custom_button.dart';
import '../../../profile/view/content/custom_text_field_with_title.dart';

class VisitNotePage extends StatelessWidget {
  final int? visitID;

  const VisitNotePage({super.key, this.visitID});

  @override
  Widget build(BuildContext context) {
    BodyVisitNote bodyVisitNote = BodyVisitNote();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              title: "next".tr(),
              padding: 16,
              clickButton: () {
                bodyVisitNote.visitId = visitID;
                context.read<VisitBloc>().add(VisitCreateNoteApi(
                    bodyVisitNote: bodyVisitNote, context: context));
              },
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Visit Note"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomTextField(
            title: tr("note"),
            hints: "Please_write_a_note".tr(),
            maxLine: 5,
            onData: (data) {
              if (kDebugMode) {
                print(data);
              }
              bodyVisitNote.note = data;
            },
          ),
        ),
      ),
    );
  }
}
