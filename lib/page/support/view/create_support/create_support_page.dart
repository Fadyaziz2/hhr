import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/support/view/create_support/create_support_content/create_support_content.dart';
import 'package:onesthrm/res/const.dart';

class CreateSupportPage extends StatelessWidget {

  const CreateSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("create_support_ticket"),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: appBarColor),
        ),
      ),
      body: const CreateSupportListContent(),
    );
  }
}
