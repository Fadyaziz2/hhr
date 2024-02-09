import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SelfiePreviewScreen extends StatelessWidget {
  const SelfiePreviewScreen(
      {super.key, required this.picture, required this.callBackButton});

  final Widget callBackButton;

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    const double mirror = math.pi;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Image'),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          width: double.infinity,
          child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(mirror),
              child: Image.file(File(picture.path), fit: BoxFit.cover)),
        ),
        const SizedBox(height: 24),

        callBackButton
      ]),
    );
  }
}
