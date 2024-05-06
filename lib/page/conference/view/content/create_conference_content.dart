import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/conference/bloc/conference_bloc.dart';
import 'package:onesthrm/res/common_text_widget.dart';

import '../../../../res/const.dart';

class CreateConferenceContent extends StatelessWidget {
  final ConferenceState? state;
  final CreateConferenceBodyModel? createConferenceBodyModel;
  const CreateConferenceContent({super.key,this.createConferenceBodyModel,this.state});

  @override
  Widget build(BuildContext context) {
    final conferenceBloc = context.read<ConferenceBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFiledWithTitle(
          title: "title".tr(),
          labelText: 'enter_title'.tr(),
          onChanged: (data){
            createConferenceBodyModel?.title = data;
          },
        ),
        const SizedBox(height: 25,),
        CommonTextFiledWithTitle(
          title: "description".tr(),
          labelText: "enter_text".tr(),
          onChanged: (data) {
            createConferenceBodyModel?.description = data;
          },
        ),
        const SizedBox(height: 25),
        Padding(padding: const EdgeInsets.only(bottom: 16.0),
          child: Text("date_schedule".tr(),
            style: TextStyle(fontSize: 14.r, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          color: colorCardBackground,
          elevation: 0.0,
          child: InkWell(
            onTap: () {
              conferenceBloc.add(SelectDatePickerSchedule(context));
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state?.currentMonthSchedule ?? 'select_date'.tr(), style: TextStyle(fontSize: 12.r),),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.grey,
                    size: 18.r,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
