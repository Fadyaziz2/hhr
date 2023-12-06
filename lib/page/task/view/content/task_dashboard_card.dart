import 'package:flutter/material.dart';

import 'content.dart';

class TaskDashboardCard extends StatelessWidget {
  const TaskDashboardCard(
      {super.key,
      this.title,
      this.count,
      required this.customPainter,
      this.titleColor,
      this.titleAsset,
      this.onTap});
  final String? title, count, titleAsset;
  final CustomPainter? customPainter;
  final Color? titleColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.25,
          height: 185,
          child: Stack(
            children: [
              Positioned(
                  top: 14,
                  left: 5,
                  right: 0,
                  child: TaskStatusCard(
                    image: titleAsset!,
                    title: title,
                    textColor: titleColor ?? Colors.black,
                  )),
              CustomPaint(
                size: Size(
                    140,
                    (140 * 0.5555555555555556)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: customPainter,
              ),
              Positioned(
                  top: 13,
                  right: 0,
                  left: 53,
                  child: Text(
                    count ?? "0",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
