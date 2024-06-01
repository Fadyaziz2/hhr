import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core/core.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function? clickButton;
  final double padding;
  final bool isLoading;
  final Color? backgroundColor;

  const CustomButton(
      {super.key,
      this.title,
      this.clickButton,
      this.padding = 10,
      this.isLoading = false,
      this.backgroundColor = colorPrimary});

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
                borderRadius: BorderRadius.circular(5.0)),
            minimumSize: Size.fromHeight(40.r),
            backgroundColor: backgroundColor),
        child: isLoading
            ? const CircularProgressIndicator(backgroundColor: Colors.white)
            : Text("$title",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.r))
                .tr(),
      ),
    );
  }
}
