import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/expense/bloc/expense_bloc.dart';
import 'package:onesthrm/page/expense/content/expense_create_body_content.dart';
import 'package:onesthrm/res/const.dart';

class ExpenseCreate extends StatelessWidget {
  final int? categoryId;
  final String? categoryName;
  const ExpenseCreate({Key? key, this.categoryId, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final user = context.read<AuthenticationBloc>().state.data;
    ExpenseCreateBody expenseCreateBody = ExpenseCreateBody();
    return BlocProvider(
        create: (context) => ExpenseBloc(
            metaClubApiClient:
                MetaClubApiClient(token: '${user?.user?.token}')),
        child: Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  tr("Create Expanse"),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              body: Form(
                // key: provider.formKey,
                child: ListView(
                  children: [
                    ExpenseCreateBodyContent(
                        categoryName: categoryName,
                        categoryId: categoryId,
                        expenseCreateBody: expenseCreateBody),
                  ],
                ),
              ),
            )));
  }
}
