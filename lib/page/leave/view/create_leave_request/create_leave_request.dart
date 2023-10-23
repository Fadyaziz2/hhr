import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/widgets/custom_button.dart';

class CreateLeaveRequest extends StatelessWidget {
  const CreateLeaveRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("request_leave")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Note",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: formKey,
              child: TextFormField(
                // controller: starDate != null
                //     ? provider.noteTextController
                //     : providerUpdate.updateNoteController,
                maxLines: 5,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Write Reason",
                  hintStyle: TextStyle(fontSize: 14),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              tr("attachment"),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: DottedBorder(
                color: const Color(0xffC7C7C7),
                borderType: BorderType.RRect,
                radius: const Radius.circular(3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                strokeWidth: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload_file,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      tr("upload_your_file"),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              tr("substitute"),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(
                  tr("add_a_Substitute"),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(tr("add_a_Designation")),
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                ),
                trailing: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
              title: "Next",
              padding: 0,
              clickButton: () {
                // NavUtil.navigateScreen(context, const LeaveCalender());
              },
            )
          ],
        ),
      ),
    );
  }
}
