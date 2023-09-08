import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/content/priority_type.dart';
import 'package:onesthrm/page/support/content/type_name_widget.dart';

import '../../../res/const.dart';

class SupportTicketItem extends StatelessWidget {
  final SupportModel supportModel;

  const SupportTicketItem({super.key, required this.supportModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              const Positioned.fill(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: colorPrimary,
                      size: 20,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    supportModel.subject ?? "",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        supportModel.date ?? "",
                        style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TypeNameWidget(supportModel: supportModel),
                      const SizedBox(
                        width: 8,
                      ),
                      PriorityType(supportModel: supportModel),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
