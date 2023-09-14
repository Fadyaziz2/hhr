import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/support/content/support_ticket_item.dart';
import 'package:onesthrm/page/support/support_bloc/support_bloc.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/no_list_found_widget.dart';

class SupportListWidget extends StatelessWidget {
  const SupportListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc, SupportState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state.status == NetworkStatus.success) {
        return state.supportListModel?.data?.data?.isEmpty == true
            ? const Expanded(
                child: NoListFoundWidget(),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.supportListModel?.data?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var item = state.supportListModel?.data?.data?[index];
                    return item != null
                        ? SupportTicketItem(supportModel: item)
                        : const SizedBox.shrink();
                  },
                ),
              );
      } else if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text("Failed to load support list"),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
