import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/meeting/bloc/meeting_bloc.dart';
import 'package:onesthrm/page/meeting/view/content/attachment_content.dart';
import 'package:onesthrm/page/meeting/view/content/meeting_time_cart.dart';
import 'package:onesthrm/page/multi_selection_employee/multi_selection_employee_page.dart';

import '../../../../res/common_text_widget.dart';

class MeetingCreateContent extends StatelessWidget {
  final MeetingState? state;
  final MeetingBodyModel? meetingBodyModel;

  const MeetingCreateContent({super.key, this.state,this.meetingBodyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFiledWithTitle(
          title: "title".tr(),
          labelText: 'enter_title'.tr(),
          onChanged: (data) {
            meetingBodyModel?.title = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        CommonTextFiledWithTitle(
          title: "description".tr(),
          labelText: "enter_text".tr(),
          onChanged: (data) {
            meetingBodyModel?.description = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        CommonTextFiledWithTitle(
          title: "location".tr(),
          labelText: 'enter_location'.tr(),
          onChanged: (data) {
            meetingBodyModel?.location = data;
          },
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "date_schedule".tr(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          child: InkWell(
            onTap: () {
              context
                  .read<MeetingBloc>()
                  .add(SelectDatePickerSchedule(context));
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.currentMonthSchedule ?? 'select_date'.tr()),
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
        MeetingTimeCart(meetingState: state),
        const SizedBox(
          height: 26,
        ),
        Card(
          child: ListTile(
            onTap: () async {
              PhoneBookUser employee = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const MultiSelectionEmployee(),
                  ));
              // // ignore: use_build_context_synchronously
              // context
              //     .read<LeaveBloc>()
              // // ignore: use_build_context_synchronously
              //     .add(SelectEmployee(employee));
            },
            title: Text(
                tr("Add Meeting Member")),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
            ),
            trailing: const Icon(Icons.add),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        AttachmentContent(meetingBodyModel: meetingBodyModel),
        const SizedBox(
          height: 26,
        ),

      ],
    );
  }
}
