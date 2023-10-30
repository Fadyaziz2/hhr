import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/expense/bloc/expense_bloc.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryPage extends StatefulWidget {
  const ExpenseCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpenseCategoryPage> createState() => _ExpenseCategoryPageState();
}

class _ExpenseCategoryPageState extends State<ExpenseCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => ExpenseBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(ExpenseCategory()),
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                tr("expense_log"),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("select_type_of_expense"),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // provider.isLoading == false
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          state.expenseCategoryData?.data?.categories?.length ??
                              0,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            state.expenseCategoryData?.data?.categories?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Card(
                            elevation: 4,
                            child: RadioListTile<String?>(
                              title: Text(data?.name ?? ''),
                              value: data?.id.toString(),
                              groupValue: state.selectedCategoryId,
                              onChanged: (String? newValue) {
                                print("saiful..$newValue");
                                context
                                    .read<ExpenseBloc>()
                                    .add(SelectedCategory(context, newValue!));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //     : const Spacer(),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // if (provider.selectCategoryData?.id != null) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (_) => ExpenseCreate(
                        //                 categoryId:
                        //                     provider.selectCategoryData?.id,
                        //                 categoryName:
                        //                     provider.selectCategoryData?.name,
                        //               )));
                        //   widget.fromEditPage == 1
                        //       ? Navigator.pop(context)
                        //       : Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (_) => const ExpenseLogExpense()));
                        // } else {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return CustomDialogError(
                        //           title: tr("select_category"),
                        //           subTitle:
                        //               tr("you_must_be_select_a_category"),
                        //         );
                        //       });
                        // }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
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
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
