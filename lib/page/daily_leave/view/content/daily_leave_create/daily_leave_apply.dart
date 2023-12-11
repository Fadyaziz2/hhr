import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_create/daily_leave_reason.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_create/daily_leave_select_time.dart';

import '../../../bloc/daily_leave_bloc.dart';
import '../../../bloc/daily_leave_state.dart';

class DailyLeaveApply extends StatelessWidget {
  const DailyLeaveApply({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
                builder: (BuildContext context, state) {
              return Column(
                children: [
                  ...List.generate(
                    context.read<DailyLeaveBloc>().leave?.length ?? 0,
                    (index) => Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: RadioListTile(
                          title: Text(context
                                      .watch<DailyLeaveBloc>()
                                      .leave?[index]
                                      .title ??
                                  '')
                              .tr(),
                          value: context.watch<DailyLeaveBloc>().leave?[index],
                          groupValue: state.leaveTypeModel,
                          onChanged: (value) {
                            context
                                .read<DailyLeaveBloc>()
                                .add(SelectLeaveType(leaveTypeModel: value!));
                          }),
                    ),
                  ),

                  /// leave time select
                  const DailyLeaveSelectTime(),
                ],
              );
            }),

            /// daily leave reason
            const DailyLeaveReason(),
          ],
        ),
      ),
    );
  }
}
