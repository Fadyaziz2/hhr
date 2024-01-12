import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../dialogs/custom_dialogs.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? initialDate;
  final Function(DateTime) onDatePicked;

  const CustomDatePicker(
      {Key? key,
      required this.label,
      required this.onDatePicked,
      this.initialDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          showCustomDatePicker(
              context: context,
              initialDate: initialDate,
              onDatePicked: (DateTime dateTime) {
                onDatePicked(dateTime);
              });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14.r),
              ),
              const Icon(Icons.date_range_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
