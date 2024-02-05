import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:onesthrm/page/attendance_qr/attendance_qr.dart';

class QRAttendanceContent extends StatefulWidget {
  const QRAttendanceContent({super.key});

  @override
  State<StatefulWidget> createState() => _QRAttendanceContentState();
}

class _QRAttendanceContentState extends State<QRAttendanceContent>
    with SingleTickerProviderStateMixin {
  String? barcode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  bool isStarted = true;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRAttendanceBloc, QRAttendanceState>(
      builder: (context, state) {
        return Builder(
          builder: (context) {
            return Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  fit: BoxFit.contain,
                  onDetect: (BarcodeCapture capture) {
                    final List<Barcode> barcodes = capture.barcodes;

                    context
                        .read<QRAttendanceBloc>()
                        .add(QRScanData(qrData: barcodes.first.rawValue));

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
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
