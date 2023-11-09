import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title, this.bgColor = colorPrimary,
  });

  final Function() onTap;
  final Widget title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: title,
    );
  }
}