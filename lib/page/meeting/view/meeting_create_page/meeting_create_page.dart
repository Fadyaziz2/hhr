import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/meeting/bloc/meeting_bloc.dart';
import 'package:onesthrm/page/meeting/view/content/meeting_create_contecnt.dart';

import '../../../../res/enum.dart';
import '../../../../res/widgets/custom_button.dart';

class MeetingCreatePage extends StatelessWidget {
  const MeetingCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
  MeetingBodyModel meetingBodyModel =  MeetingBodyModel();
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MeetingBloc,MeetingState>(
            builder: (context,state){
              return CustomButton(
                title: "Create Meeting".tr(),
                padding: 16,
                clickButton: () {
                  meetingBodyModel.startAt = state.startTime;
                  meetingBodyModel.endAt = state.endTime;
                  meetingBodyModel.date = state.currentMonthSchedule;
                  print(meetingBodyModel.toJson());
                },
              );
            },
          )
        ),
      ),
      appBar: AppBar(
        title: const Text("Meeting Create"),
      ),
      body: BlocBuilder<MeetingBloc,MeetingState>(
        builder: (context,state) {
          if (state.status == NetworkStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if( state.status == NetworkStatus.success){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MeetingCreateContent(
                          state: state, meetingBodyModel: meetingBodyModel),
                    ],
                  ),
                ),
              ),
            );
          } else if(state.status == NetworkStatus.failure) {
            return const Center(
                child: Text('Failed to load  list'));
          }else  {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
