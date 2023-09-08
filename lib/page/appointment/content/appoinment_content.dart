import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onesthrm/page/appointment/bloc/appoinment_bloc.dart';
import 'package:onesthrm/page/appointment/content/upcoming_event_widgetg.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

class AppointmentContent extends StatelessWidget {
  const AppointmentContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppoinmentBloc, AppoinmentState>(
        builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                context.read<AppoinmentBloc>().add(SelectDatePicker(context));
                // provider.selectDate(context);
              },
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<AppoinmentBloc>()
                          .add(SelectDatePicker(context));
                      // provider.selectDate(context);
                    },
                    icon: const FaIcon(FontAwesomeIcons.angleLeft,
                        size: 30, color: Colors.black),
                  ),
                  const Spacer(),
                  Center(
                      child: Text(
                    state.currentMonth ?? "Select Month",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context
                          .read<AppoinmentBloc>()
                          .add(SelectDatePicker(context));
                      // provider.selectDate(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 30,
                      // color: AppColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // provider.isLoading == true
            //     ? provider.appointmentListModel!.data!.items!.isNotEmpty
            // ?
            state.meetingsListData!.data!.items!.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          // provider.appointmentListModel?.data
                          // ?.items?.length ??
                          state.meetingsListData?.data?.items?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            state.meetingsListData?.data?.items?[index];
                        // final data = provider.appointmentListModel
                        // ?.data?.items![index];
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: InkWell(
                              onTap: () {},
                              // NavUtil.navigateScreen(
                              //     context,
                              //     AppointmentDetailsScreen(
                              //       appointmentId: data?.id,
                              //     )),
                              child: EventWidgets(
                                  isAppointment: true, data: data!),
                            ));
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Text(
                      tr("no_appointment_found"),
                      style: const TextStyle(
                          color: Color(0x65555555),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    )),
                  )
            // : const SizedBox()
          ],
        );
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(child: Text('Failed to load Appionment list'));
      }
      return const SizedBox();
    });
  }
}
