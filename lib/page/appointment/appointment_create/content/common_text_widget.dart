import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Padding buildTextTitle(title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Text(
      title,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}

TextFormField buildTextFormField({
  controller,
  labelTitle,
  onChanged,
}) {
  return TextFormField(
    onChanged: onChanged,
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xffF3F9FE).withOpacity(1),
      labelText: "$labelTitle",
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return tr("this_field_is_required");
      }
      return null;
    },
  );
}
