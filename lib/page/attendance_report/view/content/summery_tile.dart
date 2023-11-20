import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SummeryTile extends StatelessWidget {
  const SummeryTile(
      {super.key,
      required this.title,
      required this.titleValue,
      required this.color,
      this.onTap});

  final String title;
  final String titleValue;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          leading: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          title: Text(title).tr(),
          trailing: Text(
            titleValue ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Divider(
          height: 0.0,
          thickness: 1,
        )
      ],
    );
  }
}
