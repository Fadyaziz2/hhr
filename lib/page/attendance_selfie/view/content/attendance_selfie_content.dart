import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AttendanceSelfieContent extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const AttendanceSelfieContent({super.key, this.cameras});

  @override
  State<AttendanceSelfieContent> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<AttendanceSelfieContent> {
  late CameraController controller;

  // Future initCamera(CameraDescription cameraDescription) async {
  //   _cameraController = CameraController(cameraDescription, ResolutionPreset.high);
  //   try {
  //     await _cameraController.initialize().then((_) {
  //       if (!mounted) return;
  //       setState(() {});
  //     });
  //   } on CameraException catch (e) {
  //     debugPrint("camera error $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // initCamera(widget.cameras![1]);
    controller = CameraController(widget.cameras![1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          (controller.value.isInitialized)
              ? CameraPreview(controller)
              : Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator())),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black),
              child:
              IconButton(
                onPressed: takePicture,
                iconSize: 80,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.circle, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      await controller.setFlashMode(FlashMode.off);
      XFile picture = await controller.takePicture();
      if (mounted) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PreviewPage(
        //           picture: picture,
        //         )));
      }
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }
}