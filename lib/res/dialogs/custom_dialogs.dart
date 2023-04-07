import 'package:flutter/material.dart';

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