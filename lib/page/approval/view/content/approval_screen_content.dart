import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/approval/approval.dart';

class ApprovalScreenContent extends StatelessWidget {
  const ApprovalScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApprovalBloc, ApprovalState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Approval'),
          ),
          body: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: state.approval?.approvalData?.leaveRequests?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final data = state.approval?.approvalData?.leaveRequests?[index];
              return Card(
                child: ListTile(
                  title: Wrap(
                    spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Chip(
                            backgroundColor:
                                Color(int.tryParse(data?.colorCode ?? '') ?? 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5),
                            shape: const StadiumBorder(),
                            label: Text(
                              data?.status ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: Colors.white),
                            )),
                        Chip(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            shape: const StadiumBorder(),
                            label: Text(data?.type ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data?.message ?? '',
                            style: Theme.of(context)
                                .textTheme.titleMedium,),
                        )
                      ]),
                  subtitle: Row(
                    children: [
                      Chip(label: Text('Apply Date : ${data?.applyDate}'))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
