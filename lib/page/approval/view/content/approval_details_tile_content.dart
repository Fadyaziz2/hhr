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
    return Card(
      child: ListTile(
        title: Text(title, style: Theme
            .of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: const Color(0xFF6B6A70))),
        subtitle: Text(value, style: Theme
            .of(context)
            .textTheme
            .titleSmall),
      ),
    );
  }
}
