import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/payroll/payroll.dart';
import 'package:onesthrm/res/shimmers.dart';

import 'generate_payroll_shimmer.dart';

class PayrollScreenContent extends StatelessWidget {
  const PayrollScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollBloc, PayrollState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Payroll'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<PayrollBloc>().add(SelectDatePicker(context));
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        body: Stack(
          children: [
            if (state.isLoading == true) const Padding(
              padding: EdgeInsets.all(16.0),
              child: GeneratePayrollShimmer(),
            ),
            if (state.isLoading == false)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Table(
                  border: TableBorder.all(width: 0.5),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    const TableRow(
                      children: [
                        HeaderTableRow(title: 'Month'),
                        Center(child: HeaderTableRow(title: 'Salary')),
                        Center(child: HeaderTableRow(title: 'Payslip')),
                        Center(child: HeaderTableRow(title: 'Share'),),
                      ],
                    ),
                    ...List.generate(
                        state.payroll?.payrollListData?.length ?? 0, (index) {
                      final data = state.payroll?.payrollListData?[index];
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data?.month ?? '',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          Center(
                            child: Text(
                              data?.salary.toString() ?? '',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          Center(
                            child: data?.isCalculated == true
                                ? InkWell(
                                    onTap: () => context
                                        .read<PayrollBloc>()
                                        .getPaySlip(data!.payslipLink!),
                                    child: const Text('Download',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                TextDecoration.underline)),
                                  )
                                : const Text(
                                    '',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                  ),
                          ),
                          Center(
                            child: data?.isCalculated == true ? InkWell(
                              onTap: () => context.read<PayrollBloc>().sharePaySlip(data!.payslipLink!),
                              child: const Text('Share',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      decoration:
                                      TextDecoration.underline)),
                            )
                                : const Text(
                              '',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
