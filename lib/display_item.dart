import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/scanned_item.dart';
import 'package:qr_scanner/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayItem extends StatelessWidget {
  
  final Item barcode;

  const DisplayItem({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned item'),
      ),
      body: 
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScannedItemData(item: barcode),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: 
              ElevatedButton(
                onPressed: () async {
                  // Button pressed action
                  _navigateToUrl(context, barcode.value);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Go to website',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ), 
            )            
        ],),
      )
    );
  }

  Future<void> _navigateToUrl(BuildContext context, String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    try {
      await launchUrl(url);
    } catch(e) {
      showErrorSnackbarWithContext(context, "Failed to open the website );");
    }
  }
}