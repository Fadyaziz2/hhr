import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/visit/view/visit_reschedule/visit_reschedule.dart';
import 'package:onesthrm/res/const.dart';

import '../../../../res/nav_utail.dart';
import '../../bloc/visit_bloc.dart';

class RescheduleCancelButton extends StatelessWidget {
  final int? visitId;
  const RescheduleCancelButton({super.key,this.visitId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                NavUtil.navigateScreen(
                    context,
                    BlocProvider.value(
                        value: context.read<VisitBloc>(),
                        child:  VisitReschedule(visitId: visitId,)));
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const Text('Reschedule',
                  style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // NavUtil.replaceScreen(
                //     context,
                //     VisitCancelScreen(
                //       visitId: provider.visitDetails?.data?.id,
                //     ));
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const Text('Cancel',
                  style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ),
          ),
        ),

      ],
    );
  }
}
