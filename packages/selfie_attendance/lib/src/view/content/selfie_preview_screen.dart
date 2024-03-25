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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    width: double.infinity,
                    child: Transform(alignment: Alignment.center, transform: Matrix4.rotationY(mirror),
                        child: Image.file(File(picture.path), fit: BoxFit.cover)),
                  ),
                  const SizedBox(height: 16),
                  callBackButton
                ]),
              ),
              Positioned(top: 40.0,left: 25.0,child: IconButton.outlined(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_sharp,),color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
