import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/expense/content/expense_list_shimmer.dart';
import 'package:onesthrm/page/menu_drawer/bloc/menu_drawer_bloc.dart';
import 'package:onesthrm/res/enum.dart';

class PolicyContentScreen extends StatelessWidget {
  final String? appBarName;
  final String? apiSlug;
  const PolicyContentScreen({Key? key, this.appBarName, this.apiSlug})
      : super(
          key: key,
        );
  static Route route(String? appBarName, String? apiSlug) => MaterialPageRoute(
      builder: (_) => PolicyContentScreen(
            apiSlug: apiSlug,
            appBarName: appBarName,
          ));
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => MenuDrawerBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(MenuDrawerLoadData(context: context, slug: apiSlug)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarName ?? '').tr(),
        ),
        body: BlocBuilder<MenuDrawerBloc, MenuDrawerState>(
          builder: (context, state) {
            return state.responseAllContents?.data?.contents?.isNotEmpty == true
                ? SingleChildScrollView(
                    child: Html(
                    data: state
                        .responseAllContents?.data?.contents?.first.content,
                    shrinkWrap: true,
                  ))
                : const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ExpenseListShimmer(),
                  );
          },
        ),
      ),
    );
  }
}
