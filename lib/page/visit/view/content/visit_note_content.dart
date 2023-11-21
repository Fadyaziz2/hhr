import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/nav_utail.dart';
import '../../bloc/visit_bloc.dart';
import '../visit_note_page/visit_note_page.dart';

class VisitNoteContent extends StatelessWidget {
  final int? visitID;
  const VisitNoteContent({super.key,this.visitID});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Text(
            tr("visit_notes"),
            style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: (){
            NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<VisitBloc>(),
                    child:  VisitNotePage(visitID: visitID,)));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      tr("visit_notes"),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
