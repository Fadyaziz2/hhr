import 'package:flutter/material.dart';
import 'package:onesthrm/page/expense/content/expanse_drop_down_content.dart';
import 'package:onesthrm/page/expense/content/expense_list_content.dart';

class ExpansePage extends StatelessWidget {
  const ExpansePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            onPressed: () {
              // NavUtil.navigateScreen(context, const ExpanseCategory());
            },
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpenseDropDownContent(),
            ExpenseListContent(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
