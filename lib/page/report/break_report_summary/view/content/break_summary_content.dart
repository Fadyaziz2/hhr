import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/break_report_summary/break_report.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class BreakSummaryContent extends StatelessWidget {
  const BreakSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (BuildContext context, state) {
        final breakList = state.breakSummaryModel?.data?.employeeList;
        if (state.breakSummaryModel != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      state.breakSummaryModel?.data?.date ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<BreakBloc>()
                            .add(SelectDate(context, false));
                      },
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
              breakList?.isNotEmpty == true
                  ? Expanded(
                      child: ListView.builder(
                      itemCount: breakList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data = breakList?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Card(
                            child: ListTile(
                              onTap: () => NavUtil.navigateScreen(
                                context,
                                BlocProvider.value(
                                  value: context.read<BreakBloc>(),
                                  child: BreakReportList(
                                    breakUserId: data!.userId.toString(),
                                  ),
                                ),
                              ),
                              leading: ClipOval(
                                child: Image.network(
                                  data?.avatarId ??
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              title: Text(
                                data?.name ?? '',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(data?.designation ?? '',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14)),
                              trailing: Text(
                                data?.totalBreakTime ?? '',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  : const Expanded(child: NoDataFoundWidget()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Card(
                  elevation: 4,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      NavUtil.navigateScreen(
                          context,
                          BlocProvider.value(
                              value: context.read<BreakBloc>(),
                              child: const BreakReportSearch()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            tr('search_all_break_report'),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: TileShimmer(
                isSubTitle: true,
              ),
            );
          },
        );
      },
    );
  }
}
