import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:onesthrm/page/menu_drawer/bloc/menu_drawer_bloc.dart';
import 'package:onesthrm/res/enum.dart';

class SupportPolicyScreen extends StatelessWidget {
  const SupportPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuDrawerBloc, MenuDrawerState>(
      builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == NetworkStatus.success) {
          return Scaffold(
              appBar: AppBar(
                title: Text(tr("support_policy")),
              ),
              body: SingleChildScrollView(
                  child: Html(
                data: state.responseAllContents?.data?.contents?.first.content,
                shrinkWrap: true,
              )));
        }
        if (state.status == NetworkStatus.failure) {
          return const Center(child: Text('Failed to load support Data'));
        }
        return const SizedBox();
      },
    );
  }
}
