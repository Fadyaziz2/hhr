import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/expense/bloc/expense_bloc.dart';
import 'package:onesthrm/page/expense/content/expanse_drop_down_content.dart';
import 'package:onesthrm/page/expense/content/expense_category.dart';
import 'package:onesthrm/page/expense/content/expense_list_content.dart';
import 'package:onesthrm/res/nav_utail.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => ExpenseBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(GetExpenseData()),
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Expense"),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<ExpenseBloc>().add(SelectMonthPicker(context));
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ExpenseDropDownContent(state: state),
                  const ExpenseListContent(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavUtil.navigateScreen(context, const ExpenseCategoryPage());
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
