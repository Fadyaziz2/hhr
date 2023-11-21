import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../profile/view/content/custom_text_field_with_title.dart';

class VisitNotePage extends StatelessWidget {
  const VisitNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visit Note"),
      ),
      body: CustomTextField(
        title: tr("note"),
        hints: "Please_write_a_note".tr(),
        maxLine: 5,
        onData: (data) {
          if (kDebugMode) {
            print(data);
          }
          // bodyCreateVisit.description = data;
        },
      ),
    );
  }
}
