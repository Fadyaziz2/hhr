import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../page/login/view/login_page.dart';

Future<void> showRegistrationSuccessDialog(
    {required BuildContext context,
    bool isSuccess = true,
    String message = 'Account Verification',
    String body = 'Your account verification now on process. we will notify you after completing your verification'}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Center(
              child: Text(
            message ?? '',
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
              body ?? '',
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
      String body = 'Your account verification now on process. we will notify you after completing your verification'})  {
   showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Center(
              child: Text(
                message ?? '',
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
              body ?? '',
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'))
          ],
        );
      });
}

showCustomYearPicker({required BuildContext context,required Function(DateTime dateTime) onDatePicked,DateTime? initialDate}) {
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
              child: SfDateRangePicker(
                onSelectionChanged: (arg) {
                  onDatePicked(arg.value);
                  Navigator.of(context).pop();
                },
                onSubmit: (arg) {},
                maxDate: DateTime.now().add(const Duration(days: 365)),
                initialDisplayDate: initialDate ?? DateTime.now(),
                view: DateRangePickerView.year,
                selectionMode: DateRangePickerSelectionMode.single,
                  monthViewSettings:
                  DateRangePickerMonthViewSettings(enableSwipeSelection: false),
                allowViewNavigation: true,
                  toggleDaySelection: false,
                  yearCellStyle: DateRangePickerYearCellStyle(
                    disabledDatesDecoration:BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                        shape: BoxShape.circle),
                    disabledDatesTextStyle: const TextStyle(color: Colors.black),
                    leadingDatesDecoration:BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                        shape: BoxShape.circle),
                    leadingDatesTextStyle: const TextStyle(color: Colors.black),
                    textStyle: const TextStyle(color: Colors.blue),
                    todayCellDecoration: BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                        shape: BoxShape.circle),
                    todayTextStyle: const TextStyle(color: Colors.green),
                  )
              ),
            ),
          ],
        ),
      );
    },
  );
}

showCustomDatePicker({required BuildContext context,required Function(DateTime dateTime) onDatePicked,DateTime? initialDate}) {
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
              child: SfDateRangePicker(
                onSelectionChanged: (arg) {
                  onDatePicked(arg.value);
                  Navigator.of(context).pop();
                },
                onSubmit: (arg) {},
                maxDate: DateTime.now().add(const Duration(days: 365)),
                initialDisplayDate: initialDate ?? DateTime.now(),
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                allowViewNavigation: true,
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
      {Key? key, this.onCameraClick, this.onGalleryClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: 210,
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
                      Lottie.asset("assets/images/ic_camera.json",height: 50,width: 50),
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
                        Lottie.asset("assets/images/ic_gallery.json",height: 50,width: 50),
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

Future<File?> pickFile(BuildContext context) async {

  File? file;

  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialogImagePicker(
        onCameraClick: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
              source: ImageSource.camera,
              maxHeight: 320,
              maxWidth: 300);
          file = File(image!.path);
          debugPrint(image.path);
          Navigator.of(context).pop(file);
        },
        onGalleryClick: () async {
          final ImagePicker pickerGallery = ImagePicker();
          final XFile? imageGallery = await pickerGallery.pickImage(
              source: ImageSource.gallery,
              maxHeight: 320,
              maxWidth: 300);
          file = File(imageGallery!.path);
          debugPrint(file?.path);
          Navigator.of(context).pop(file);
        },
      );
    },
  );
}