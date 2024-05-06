import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/conference/bloc/conference_bloc.dart';
import 'package:onesthrm/page/conference/view/content/create_conference_content.dart';

import '../../../res/enum.dart';
import '../../../res/widgets/custom_button.dart';
import '../../leave/view/content/leave_list_shimmer.dart';

class CreateConferencePage extends StatelessWidget {
  const CreateConferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    CreateConferenceBodyModel createConferenceBodyModel = CreateConferenceBodyModel();
    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(0.8),
          child: BlocBuilder<ConferenceBloc,ConferenceState>(
            builder: (context,state){
              return CustomButton(
                title: "Create Conference".tr(),
                padding: 16,
                isLoading: state.status == NetworkStatus.loading,
                clickButton: () {
                  final currentDate = DateFormat('y-MM').format(DateTime.now());
                  if (formKey.currentState!.validate() &&
                      state.status == NetworkStatus.success) {
                    // meetingBodyModel.participants =
                    //     state.selectedIds.join(',');
                    // meetingBodyModel.startAt = state.startTime;
                    // meetingBodyModel.endAt = state.endTime;
                    // meetingBodyModel.date = state.currentMonthSchedule;
                    // context.read<MeetingBloc>().add(CreateMeetingEvent(
                    //     bodyCreateMeeting: meetingBodyModel,
                    //     date: currentDate,
                    //     context: context));
                  }
                },
              );
            },
          ),
        ),),
        appBar: AppBar(
          title: const Text("Create Conference"),
        ),
        body: BlocBuilder<ConferenceBloc,ConferenceState>(
          builder: (context,state){
            if (state.status == NetworkStatus.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LeaveListShimmer(),
              );
            } else if(state.status == NetworkStatus.success){
              return  SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(16),
                child: CreateConferenceContent(state: state,createConferenceBodyModel: createConferenceBodyModel,),),
              );
            }else if(state.status == NetworkStatus.failure){
              return Center(child: const Text("failed_to_load_list").tr(),);
            }else {
              return const SizedBox();
            }
          }
        ),
      ),
    );
  }
}
