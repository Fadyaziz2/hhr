import 'package:flutter/material.dart';

class CardTileWithContent extends StatelessWidget {
  const CardTileWithContent({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.labelSmall;
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: style!.copyWith(
            color: const Color(0xFF6B6A70),
          ),
        ),
        subtitle: Text(value, style: style),
      ),
    );
  }
}
