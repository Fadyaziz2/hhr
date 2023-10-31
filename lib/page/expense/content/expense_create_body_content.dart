import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/expense/bloc/expense_bloc.dart';
import 'package:onesthrm/page/expense/content/attachment_content.dart';
import 'package:onesthrm/res/common_text_widget.dart';
import 'package:onesthrm/res/const.dart';

class ExpenseCreateBodyContent extends StatelessWidget {
  final int? categoryId;
  final String? categoryName;
  const ExpenseCreateBodyContent({
    super.key,
    this.categoryId,
    this.categoryName,
    required this.expenseCreateBody,
  });

  final ExpenseCreateBody expenseCreateBody;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                color: Colors.blue[50],
                child: ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: const Icon(Icons.list_alt),
                  trailing: Text(
                    tr("change"),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  title: Center(child: Text(categoryName ?? '')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextFiledWithTitle(
                      onChanged: (value) {
                        expenseCreateBody.amount = value;
                      },
                      title: "Amount",
                      labelText: 'Enter Amount',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonTextFiledWithTitle(
                      title: "Reference",
                      labelText: 'Enter reference',
                      onChanged: (value) {
                        expenseCreateBody.reference = value;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "date_schedule",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<ExpenseBloc>()
                              .add(SelectDatePicker(context));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.selectDate ?? 'Select Date'),
                              const Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonTextFiledWithTitle(
                      title: "Description",
                      labelText: 'Enter description',
                      onChanged: (value) {
                        expenseCreateBody.description = value;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ExpenseAttachmentContent(
                      expenseCreateBody: expenseCreateBody,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            expenseCreateBody.date = state.selectDate;
                            expenseCreateBody.categoryId = categoryId;
                            context.read<ExpenseBloc>().add(ExpenseCreateButton(
                                context, expenseCreateBody));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(colorPrimary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text(tr("next"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
