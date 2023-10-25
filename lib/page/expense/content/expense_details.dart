import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/expense/content/expense_details_item_cart.dart';
import 'package:provider/provider.dart';

class ExpenseDetails extends StatelessWidget {
  final ExpenseItem? data;
  final int? expenseId;
  const ExpenseDetails({Key? key, this.expenseId, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 4, title: const Text('Expense Details')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: Column(
          children: [
            ExpenseDetailsItemCart(
              title: "Requested Amount",
              value: data?.requestedAmount,
            ),
            ExpenseDetailsItemCart(
              title: "Approved Amount",
              value: data?.approvedAmount,
            ),
            ExpenseDetailsItemCart(
              title: "Date Show",
              value: data?.dateShow,
            ),
            ExpenseDetailsItemCart(
              title: "Payment",
              value: data?.payment,
            ),
            ExpenseDetailsItemCart(
              title: "Status",
              value: data?.status,
            ),
            ExpenseDetailsItemCart(
              title: "Reason",
              value: data?.reason ?? 'No Reason Available',
            ),
          ],
        ),
      ),
    );
  }
}
