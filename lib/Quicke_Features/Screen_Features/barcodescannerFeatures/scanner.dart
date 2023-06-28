import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../providers/HomeProviders.dart';
import 'Qr_Layer.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          // backgroundColor: appColor,
          title: Text("QR Scanner"),
          actions: const [
            // IconButton(
            //     onPressed: () {
            //       controller.switchCamera();
            //    },
            //   icon: Icon(Icons.camera_alt_outlined))
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              // fit: BoxFit.contain,
              controller: MobileScannerController(
                facing: CameraFacing.back,
                autoStart: true,
                detectionSpeed: DetectionSpeed.normal,
                // torchEnabled: true,
              ),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;

                if (barcodes.isNotEmpty) {
                  final String barcodeValue = barcodes.first.rawValue!;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Barcode Found'),
                      content: Text('Barcode value: $barcodeValue'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }

                if (image != null) {
                  showDialog(
                    context: context,
                    builder: (context) => Image(image: MemoryImage(image)),
                  );
                  Future.delayed(const Duration(seconds: 5), () {
                    Navigator.pop(context);
                  });
                }
              },
            ),
            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
