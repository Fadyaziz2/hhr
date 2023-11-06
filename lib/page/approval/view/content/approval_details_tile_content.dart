import 'package:flutter/material.dart';

class ApprovalDetailsTileContent extends StatelessWidget {
  const ApprovalDetailsTileContent({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.5),
              bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelSmall!.copyWith(color:  const Color(0xFF6B6A70))),
          Text(value, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
