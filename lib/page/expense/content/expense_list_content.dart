import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/expense/bloc/expense_bloc.dart';
import 'package:onesthrm/page/expense/content/expense_details.dart';
import 'package:onesthrm/page/expense/content/expense_list_shimmer.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class ExpenseListContent extends StatelessWidget {
  final ExpenseState? state;
  const ExpenseListContent({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return state?.responseExpenseList?.data != null
        ? state?.responseExpenseList?.data?.isNotEmpty == true
            ? Expanded(
                child: ListView.builder(
                  itemCount: state?.responseExpenseList?.data?.length ?? 0,
                  itemBuilder: (context, i) {
                    final data = state?.responseExpenseList?.data?[i];
                    return InkWell(
                      onTap: () {
                        NavUtil.navigateScreen(
                            context, ExpenseDetails(data: data));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: ListTile(
                              title: Text(
                                data?.category ?? "",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(int.parse(
                                              data?.statusColor ?? '')),
                                          // color: Color(int.parse(provider
                                          //         .expenseList?[i]
                                          //         .statusColor ??
                                          //     '')),
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                        ),
                                        color: Color(
                                            int.parse(data?.statusColor ?? '')),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: DottedBorder(
                                        color: Colors.white,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        strokeWidth: 1,
                                        child: Text(
                                          data?.status ?? '',
                                          // provider.expenseList?[i].status ??
                                          // '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(int.parse(
                                              data?.paymentColor ?? '')),
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                        ),
                                        color: Color(int.parse(
                                            data?.paymentColor ?? '')),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: DottedBorder(
                                        color: Colors.white,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        strokeWidth: 1,
                                        child: Text(
                                          data?.payment ?? '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Text(data?.dateShow ?? ""),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Expanded(child: NoDataFoundWidget())
        : const ExpenseListShimmer();
  }
}
