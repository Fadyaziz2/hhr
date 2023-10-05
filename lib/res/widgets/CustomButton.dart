import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function? clickButton;
  final double padding;

  const CustomButton({Key? key, this.title, this.clickButton,this.padding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: padding),
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (clickButton != null) clickButton!();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
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
