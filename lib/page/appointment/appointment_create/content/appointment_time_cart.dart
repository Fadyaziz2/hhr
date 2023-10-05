import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appointment_create_bloc.dart';

class AppointmentTimeCart extends StatelessWidget {
  final AppointmentCreateState? state;
  const AppointmentTimeCart({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("start_time"),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    context.read<AppointmentCreateBloc>().add(SelectStartTime(
                          context,
                        ));
                  },

                  // provider.showTime(context, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state?.startTime ?? tr("start_time")),
                        // provider.startTime ??
                        // tr("start_time")),
                        const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("end_time"),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    context.read<AppointmentCreateBloc>().add(SelectEndTime(
                          context,
                        ));
                  },
                  // provider.showTime(context, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state?.endTime ??
                            // provider.endTime ??
                            tr("end_time")),
                        const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
