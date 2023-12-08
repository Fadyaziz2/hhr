import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesthrm/page/break/bloc/break_bloc.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class BreakReportScreen extends StatelessWidget {
  const BreakReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr("break_time_report")),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<BreakBloc>().add(SelectDatePicker(context));
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          body: Column(
            children: [
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
                      tr("total_break_time"),
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      state.breakReportModel?.data?.totalBreakTime ??
                          "00:00:00",
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
                height: 16.0,
              ),
              if (state.breakReportModel != null)
                state.breakReportModel!.data!.breakHistory?.todayHistory
                            ?.isNotEmpty ==
                        true
                    ? Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      state
                                              .breakReportModel
                                              ?.data
                                              ?.breakHistory
                                              ?.todayHistory?[index]
                                              .breakTimeDuration ??
                                          "",
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
                                      Text(
                                        state
                                                .breakReportModel
                                                ?.data
                                                ?.breakHistory
                                                ?.todayHistory?[index]
                                                .reason ??
                                            "",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ).tr(),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(state
                                              .breakReportModel
                                              ?.data
                                              ?.breakHistory
                                              ?.todayHistory?[index]
                                              .breakBackTime ??
                                          ""),
                                    ],
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: state.breakReportModel?.data
                                    ?.breakHistory?.todayHistory?.length ??
                                0),
                      )
                    : const Expanded(child: NoDataFoundWidget())
            ],
          ),
        );
      },
    );
  }
}
