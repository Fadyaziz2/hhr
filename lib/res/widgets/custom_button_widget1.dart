import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double radius;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final bool asyncCall;

  const CustomButton1(
      {Key? key,
      required this.onTap,
      required this.text,
      this.radius = 8.0,
      this.textColor = Colors.white,
      this.fontWeight = FontWeight.bold,
      this.asyncCall = false,
      this.textSize = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: asyncCall ? null : onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        child: asyncCall
            ?  Center(
                child: CircularProgressIndicator(color: textColor,),
              )
            : Text(text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: textSize,
                )),
      ),
    );
  }
}
