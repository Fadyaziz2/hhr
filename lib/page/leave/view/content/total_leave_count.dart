import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';

class TotalLeaveCount extends StatelessWidget {
  const TotalLeaveCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "total_leaves",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ).tr()
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "20",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: colorPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "leaves_used",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ).tr()
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "10",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
