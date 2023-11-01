import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function? clickButton;
  final double padding;
  final Color? backgroundColor;

  const CustomButton(
      {Key? key,
      this.title,
      this.clickButton,
      this.padding = 10,
      this.backgroundColor = colorPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (clickButton != null) clickButton!();
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            minimumSize: const Size.fromHeight(50),
            backgroundColor: backgroundColor),
        child: Text("$title",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
      ),
    );
  }
}
