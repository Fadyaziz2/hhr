import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../page/login/view/login_page.dart';

Future<void> showRegistrationSuccessDialog(
    {required BuildContext context,
    bool isSuccess = true,
    String message = 'Account Verification',
    String body = ''}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Center(
              child: Text(
            message,
            style: const TextStyle(fontSize: 18.0),
          )),
          contentPadding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: isSuccess ? Colors.green : Colors.red,
              child: Icon(
                isSuccess ? Icons.done : Icons.close,
                size: 60.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              body,
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, LoginPage.route(), (_) => false),
                child: const Text('Back'))
          ],
        );
      });
}

void showLoginDialog(
    {required BuildContext context,
    bool isSuccess = true,
    String message = 'Account Login',
    String body = ''}) {
  showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Center(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0),
          )),
          contentPadding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: isSuccess ? Colors.green : Colors.red,
              child: Icon(
                isSuccess ? Icons.done : Icons.close,
                size: 60.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              body,
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'))
          ],
        );
      });
}


showYearPicker(
    {required BuildContext context,
    required Function(DateTime dateTime) onDatePicked,
    DateTime? initialDate,
    required DateTime selectDate}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Select Year',
              style: Theme.of(context).textTheme.titleMedium),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 5),
              lastDate: DateTime.now(),
              selectedDate: selectDate,
              onChanged: onDatePicked,
            ),
          ),
        );
      });

}

showCustomDatePicker(
    {required BuildContext context,
    required Function(DateTime dateTime) onDatePicked,
    DateTime? initialDate}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: CalendarDatePicker(
                initialDate: initialDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateChanged: (selectedDate) {
                  onDatePicked(selectedDate);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class CustomDialogImagePicker extends StatelessWidget {
  final Function? onCameraClick;
  final Function? onGalleryClick;

  const CustomDialogImagePicker(
      {super.key, this.onCameraClick, this.onGalleryClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        color: Colors.white,
        height: 215,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Select Image",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (onCameraClick != null) onCameraClick!();
                  },
                  child: Column(
                    children: [
                      Lottie.asset("assets/images/ic_camera.json",
                          height: 50, width: 50),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                InkWell(
                  onTap: () {
                    if (onGalleryClick != null) onGalleryClick!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      children: [
                        Lottie.asset("assets/images/ic_gallery.json",
                            height: 50, width: 50),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialogFaceError extends StatelessWidget {
  final Function? onYesClick;
  final Function? onNoClick;

  const CustomDialogFaceError(
      {super.key, this.onYesClick, this.onNoClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 340,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Lottie.asset("assets/images/face_error.json",height: 200,width: 200)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("Make sure the registration of your face is correct before you try again if your face does not match",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text("Okay",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}

Future<File?> pickFile(BuildContext context) async {
  File? file;

  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialogImagePicker(
        onCameraClick: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
              source: ImageSource.camera, maxHeight: 320, maxWidth: 300);
          file = File(image!.path);
          debugPrint(image.path);
          if (!context.mounted) return;
          Navigator.of(context).pop(file);
        },
        onGalleryClick: () async {
          final ImagePicker pickerGallery = ImagePicker();
          final XFile? imageGallery = await pickerGallery.pickImage(
              source: ImageSource.gallery, maxHeight: 320, maxWidth: 300);
          file = File(imageGallery!.path);
          debugPrint(file?.path);
          if (!context.mounted) return;
          Navigator.of(context).pop(file);
        },
      );
    },
  );
}
