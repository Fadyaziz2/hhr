import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../res/common/debouncer.dart';

class AttendanceQRView extends StatefulWidget {

  const AttendanceQRView({super.key});

  @override
  State<StatefulWidget> createState() => _AttendanceQRViewState();
}

class _AttendanceQRViewState extends State<AttendanceQRView>
    with SingleTickerProviderStateMixin {
  String? barcode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    // formats: [BarcodeFormat.qrCode]
    // facing: CameraFacing.front,
  );

  bool isStarted = true;
  final Debounce _debounce = Debounce(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                onDetect: (BarcodeCapture capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  final data = {'qr_scan': barcodes.first.rawValue};

                  // _debounce(() async {
                  //   /*final response = await Repository.qrCodeCheck(data);
                  //   if (response.httpCode == 200) {
                  //     if (mounted) {
                  //       NavUtil.replaceScreen(
                  //           context,
                  //           Attendance(
                  //               navigationMenu: true,
                  //               qrData: barcodes.first.rawValue));
                  //     }
                  //   } else {
                  //     Fluttertoast.showToast(msg: '${response.message}');
                  //   }*/
                  // });
                  _debounce.run(() {
                    print("qr_scan: ${barcodes.first.rawValue}");
                  });

                 },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.torchState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(
                                CupertinoIcons.lightbulb_fill,
                                color: Colors.grey,
                              );
                            }
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  CupertinoIcons.lightbulb_slash,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  CupertinoIcons.lightbulb_fill,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    "assets/images/face.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
