import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ExpenseDropDownContent extends StatelessWidget {
  const ExpenseDropDownContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  tr("Select Payment"),
                  style: const TextStyle(fontSize: 14),
                ),
                // value: provider.paymentTypeValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  size: 20,
                ),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  // provider.paymentTypeMenu(newValue, context);
                },
                items: ["Paid", "Unpaid"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  tr("Expanse Status"),
                  style: const TextStyle(fontSize: 14),
                ),
                // value: provider.expenseStatus,
                icon: const Icon(
                  Icons.arrow_downward,
                  size: 20,
                ),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  // provider.expenseStatusMenu(newValue, context);
                },
                items: ["Pending", "Approved", "Rejected"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
