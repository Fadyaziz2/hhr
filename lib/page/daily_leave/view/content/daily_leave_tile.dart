import 'package:flutter/material.dart';

class DailyLeaveTile extends StatelessWidget {
  const DailyLeaveTile(
      {super.key, required this.title, required this.value, this.onTap});

  final String title;
  final String value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(100)),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
