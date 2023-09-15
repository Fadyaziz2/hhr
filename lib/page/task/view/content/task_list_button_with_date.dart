import 'package:flutter/material.dart';

class TaskListButtonWithDate extends StatelessWidget {
  const TaskListButtonWithDate(
      {super.key,
      required this.buttonColor,
      required this.firstDate,
      required this.endData,
      required this.verticalPadding});

  final Color? buttonColor;
  final String? firstDate, endData;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: verticalPadding!, horizontal: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: buttonColor!,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/task/calender.png",
            height: 18.0,
            width: 18.0,
          ),
          const SizedBox(
            width: 04.0,
          ),
          Text(
            firstDate!,
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const SizedBox(
            width: 04.0,
          ),
          Text(
            endData ?? "",
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
