import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String title;
  final String? hints;
  final String? value;
  final Function(String?) onData;

  const CustomTextField({Key? key,required this.title, this.value,required this.onData,this.hints,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.name,
          onChanged: onData,
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            hintText: hints,
            hintStyle: const TextStyle(fontSize: 12),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
      ],
    );
  }
}
