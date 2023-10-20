import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ExpenseListContent extends StatelessWidget {
  const ExpenseListContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              // NavUtil.navigateScreen(
              //     context,
              //     ExpenseDetail(
              //       expenseId: provider.expenseList?[i].id,
              //     ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListTile(
                    title: const Text(
                      // provider.expenseList?[i].category ??
                      "",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                // color: Color(int.parse(provider
                                //         .expenseList?[i]
                                //         .statusColor ??
                                //     '')),
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              // color: Color(int.parse(provider
                              //         .expenseList?[i]
                              //         .statusColor ??
                              //     '')),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: const Text(
                                // provider.expenseList?[i].status ??
                                '',
                                style: TextStyle(
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
                                // color: Color(int.parse(provider
                                //         .expenseList?[i]
                                //         .paymentColor ??
                                //     '')),
                                style: BorderStyle.solid,
                                width: 3.0,
                              ),
                              // color: Color(int.parse(provider
                              //         .expenseList?[i]
                              //         .paymentColor ??
                              //     '')),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DottedBorder(
                              color: Colors.white,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              strokeWidth: 1,
                              child: const Text(
                                // provider.expenseList?[i].payment ??
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Text(
                        // provider.expenseList?[i].dateShow ??
                        ""),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
