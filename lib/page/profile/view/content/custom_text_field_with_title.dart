import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/res/widgets/device_util.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hints;
  final String? value;
  final int? maxLine;
  final Function(String?) onData;
  final String? errorMsg;
  final double? sizedBoxHeight;

  const CustomTextField(
      {super.key,
      required this.title,
      this.value,
      required this.onData,
      this.hints,
      this.maxLine,
      this.errorMsg,
      this.sizedBoxHeight = 10.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.r,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: sizedBoxHeight,
        ),
        TextFormField(
          maxLines: maxLine,
          style: TextStyle(fontSize: 14.r),
          keyboardType: TextInputType.name,
          onChanged: onData,
          validator: (val) => val!.isEmpty ? errorMsg : null,
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              hintText: hints,
              hintStyle: TextStyle(fontSize: 12.r),
              errorStyle: TextStyle(fontSize: 12.r),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),),
        ),
      ],
    );
  }
}
