import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/display_item.dart';
import 'package:qr_scanner/ui/scanned_item.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});
  
  @override
  State<StatefulWidget> createState() => ScannerState(); 
}

class ScannerState extends State<Scanner> {
  List<Barcode> scannedBarcodes = [];
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

  Future<void> _displayItem(Item item) async {
    controller.stop();
    
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayItem(barcode: item)),
    );

    controller.start();        
  }

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height, // 20% of the screen height
        width: MediaQuery.of(context).size.width,  // 50% of the screen width
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: _displayBarcodes(),
      );
  }

  Widget _displayBarcodes() {
    List<Widget> items = [];
    items.add(_buildScanner());
    
    //Add scanned items that is not empty.
    for(Barcode b in scannedBarcodes) {
      final typeAndValue = convertBarcode(b);
      if(!typeAndValue.isEmpty()) {
        items.add(ScannedItem(item: typeAndValue, number: items.length, onTap: () {
          _displayItem(typeAndValue);
        }));
      }
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: items[index],
                );
    });
  }

  Widget _buildScanner() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.black,
            ),
        SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // 20% of the screen height
              width: MediaQuery.of(context).size.width * 0.9,  // 50% of the screen width
              child: MobileScanner(
                //scanWindow: Rect.fromCenter(center: center, width: width, height: height),
                controller: controller,
                //fit: BoxFit.contain,
                onDetect: (capture) async {
                  final List<Barcode> barcodes = capture.barcodes;
                  debugPrint("Number of barcodes= ${barcodes.length}");
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');
                    debugPrint('Url= ${barcode.url}');
                    debugPrint('displayValue = ${barcode.displayValue}');
                    debugPrint('type = ${barcode.type.toString()}');
                    debugPrint('The whole barcode= ${barcode.toString()}');
                    
                    setState(() {
                      scannedBarcodes.add(barcode);
                    });

                    //Navigate to new page to display the scanned item.
                    final item = convertBarcode(barcode);
                    _displayItem(item);
                    debugPrint("Navigated back to scanner. Start camera");

                  }

                  debugPrint("Exited onDetect");
                },
              ),
            ),
    ],); 
  }

  //TODO implement all types.
  Item convertBarcode(Barcode barcode) {
    final type = barcode.type;
    switch(type) {
      case BarcodeType.unknown:
        return Item(type: "", value: "");
      case BarcodeType.contactInfo:
        return Item(type: "Contact info", value: barcode.contactInfo!.name!.formattedName ?? "");
      case BarcodeType.email:
        return Item(type: "Email", value: barcode.email!.address ?? "");
      case BarcodeType.isbn:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.phone:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.product:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.sms:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.text:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.url:
        return Item(type: "Url", value: barcode.url!.url);
      case BarcodeType.wifi:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.geo:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.calendarEvent:
        return Item(type: "TODO implement", value: "TODO implement");
      case BarcodeType.driverLicense:
        return Item(type: "TODO implement", value: "TODO implement");
    }
  }
}
