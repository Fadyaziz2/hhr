import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';

Padding buildLeaveTitle() {
  return Padding(
    padding:
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 2),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: colorPrimary,
                ),
                // child: Text('$month'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 12),),
                child: const Text(
                  "OCT",
                  style: TextStyle(
                      color: Colors.white, fontSize: 12),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(6.0),
                // child: Text('$date', style: const TextStyle(fontSize: 14),),
                child: Text(
                  '20',
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "Casual Leave ",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ).tr(),
                  Text(
                    // '${leave.days} ${tr('days')}',
                    '1 ${tr('days')}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ).tr(),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    // color: Color(int.parse(leave.colorCode ?? "")),
                    color: Colors.green,
                    style: BorderStyle.solid,
                    width: 3.0,
                  ),
                  // color: Color(int.parse(leave.colorCode ?? "")),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DottedBorder(
                  color: Colors.white,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  strokeWidth: 1,
                  child: const Center(
                    child: Text(
                      // '${leave.status}',
                      'Pending',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorPrimary.withOpacity(0.1)),
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        )
      ],
    ),
  );
}