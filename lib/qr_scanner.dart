import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});
  
  @override
  State<StatefulWidget> createState() => ScannerState(); 
}

class ScannerState extends State<Scanner> {
  ScannerState();

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        height: MediaQuery.of(context).size.height * 0.5, // 20% of the screen height
        width: MediaQuery.of(context).size.width * 0.9,  // 50% of the screen width
        child: MobileScanner(
          //scanWindow: Rect.fromCenter(center: center, width: width, height: height),
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.front,
            torchEnabled: true,
          ),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
            }
          },
        )
      );
  }
}
