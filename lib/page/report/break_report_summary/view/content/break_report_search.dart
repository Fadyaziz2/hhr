import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesthrm/page/report/break_report_summary/break_report.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class BreakReportSearch extends StatelessWidget {
  const BreakReportSearch({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BreakBloc>().add(BreakSummaryDetails());
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (BuildContext context, state) {
        final reportBreakData =
            state.reportBreakListModel?.data?.breakHistory?.todayHistory;
        return Scaffold(
          appBar: AppBar(
            title: Text(tr('break_time_report')),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<BreakBloc>().add(SelectDate(context, true));
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectEmployeePage(),
                          )).then((value) {
                        if (value != null) {
                          context.read<BreakBloc>().add(SelectEmployee(value));
                        }
                      });
                    },
                    title: Text(context
                            .watch<BreakBloc>()
                            .state
                            .selectEmployee
                            ?.name! ??
                        'Select Employee'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(context
                              .watch<BreakBloc>()
                              .state
                              .selectEmployee
                              ?.avatar ??
                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                    ),
                    trailing: const Icon(Icons.search),
                  ),
                ),
              ),
              Container(
                color: const Color(0xff6AB026),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${tr('total_break_time')}:",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      state.reportBreakListModel?.data?.totalBreakTime ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: "digitalNumber"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              reportBreakData?.isNotEmpty == true
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reportBreakData?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = reportBreakData?[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        data?.breakTimeDuration ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 3,
                                      color: colorPrimary,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Break",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(data?.breakBackTime ?? ''),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const NoDataFoundWidget()
            ],
          ),
        );
      },
    );
  }
}
