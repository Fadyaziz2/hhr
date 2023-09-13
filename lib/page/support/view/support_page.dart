import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/support/support_bloc/support_bloc.dart';
import 'package:onesthrm/page/support/view/create_support/create_support_page.dart';
import 'package:onesthrm/page/support/view/support_list_content/support_list_content.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => SupportBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(GetSupportData()),
      child: BlocBuilder<SupportBloc, SupportState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: colorPrimary,
              onPressed: () {
                NavUtil.navigateScreen(
                    context,
                    BlocProvider.value(
                      value: context.read<SupportBloc>(),
                      child: const CreateSupportPage(),
                    ));
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF00CCFF),
                        colorPrimary,
                      ],
                      begin: FractionalOffset(3.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              title: Text(
                tr("all_support_tickets"),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: appBarColor),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<SupportBloc>().add(SelectDatePicker(context));
                    },
                    icon: const Icon(Icons.calendar_month_outlined))
              ],
            ),
            body: const SupportListContent(),
          );
        },
      ),
    );
  }
}
