import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});
  
  @override
  State<StatefulWidget> createState() => ScannerState(); 
}

class ScannerState extends State<Scanner> {
  List<Barcode> barcodes = [];
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool isStarted = true;

  ScannerState();

  @override
  void initState() {
    super.initState();

    if(isStarted) {
      controller.start();
    }
  }

  //TODO fix the scrolling. I want to be able to scroll down where the scanner is kinda "attached" to the top
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height, // 20% of the screen height
        width: MediaQuery.of(context).size.width,  // 50% of the screen width
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // 20% of the screen height
              width: MediaQuery.of(context).size.width * 0.9,  // 50% of the screen width
              child: MobileScanner(
                //scanWindow: Rect.fromCenter(center: center, width: width, height: height),
                controller: controller,
                //fit: BoxFit.contain,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');
                    debugPrint('Url= ${barcode.url}');
                    debugPrint('The whole barcode= ${barcode.toString()}');
                  }
                },
              ),
            ),
            const SizedBox(width: 0, height: 20,),
            Expanded(              
              child: _displayBarcodes(),
            )
          ],
        )
      );
  }

  Widget _displayBarcodes() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.green, // Border color
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            const Text(
              "Test",
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Number: $index',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    });
  }
}
