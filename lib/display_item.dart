import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/scanned_item.dart';
import 'package:url_launcher/url_launcher.dart';


//TODO add timestamp?
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
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              //margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.green, // Border color
                  width: 2.0,
                ),
              ),
              child: Text(
                  barcode.value,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: 
              ElevatedButton(
                onPressed: () {
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

  //TODO This works! But there is a problem where once the link has been clicked and you return to the application,
  // it is stuck at the same spot  
  void _navigateToUrl(BuildContext context, String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    try {
      launchUrl(url);
    } catch(e) {
      _showErrorSnackbar(context, "Failed to open the website );");
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Some action to take when the user presses the "OK" button
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}