import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AssignAlertDialog extends StatelessWidget {
  const AssignAlertDialog({ required this.assignMembers,
    super.key,
  });

  final TaskDetailsMember assignMembers;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: assignMembers.name != null ? Text("Name : ${assignMembers.name} ") : const SizedBox(),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              assignMembers.designation != null
                  ? Text("Designation : ${assignMembers.designation ?? ""}")
                  : const SizedBox(),
              assignMembers.department != null
                  ? Text("Department : ${assignMembers.department ?? ""}")
                  : const SizedBox(),
              assignMembers.phone != null
                  ? Text("Phone : ${assignMembers.phone ?? ""}")
                  : const SizedBox(),
              assignMembers.email != null
                  ? Text("Email : ${assignMembers.email ?? ""}")
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
