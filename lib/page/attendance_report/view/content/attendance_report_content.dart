import 'package:flutter/material.dart';

class AttendanceReportContent extends StatelessWidget {
  const AttendanceReportContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 20, bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: const SizedBox(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "working_days",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  const Spacer(),
                  const Text("0")
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: const Text('Working Days'),
              leading: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const SizedBox(),
              ),
              trailing: Text(
                "0",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
