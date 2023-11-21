import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VisitNoteContent extends StatelessWidget {
  const VisitNoteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
