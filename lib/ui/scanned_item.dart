

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/utils.dart';

//Basic class for holding the data. Should probably be moved to a model folder / file.
class Item {
  final String type;
  final String value;
  final String timeStamp;

  Item({required this.type, required this.value, required this.timeStamp});

  bool isEmpty() {
    return type.isEmpty && value.isEmpty || timeStamp.isEmpty;
  }
}

abstract class ScannedItemBase extends StatelessWidget {
  //Data for UI.
  final double borderWidth = 1.0;
  final Color borderColor = Colors.black;

  //Data to display.
  final Item item;

  const ScannedItemBase({super.key, required this.item});
}

//Widget for displaying the data without a number.
class ScannedItemData extends ScannedItemBase {
  
  //If this is not set to true, the item will not be wrapped with a border.
  final bool fullBorder;
  const ScannedItemData({super.key, required super.item, this.fullBorder = true});

  @override
  Widget build(BuildContext context) {
    
    Decoration decoration;
    if(fullBorder) {
      decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),  //TODO make this as a variable in the base calass aswell?
          border: Border.all(
            color: borderColor, // Border color
            width: borderWidth,
          ),
        );
    } else {
      decoration = BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: borderColor, // Border color
                  width: borderWidth,
                ),
              ),
            );
    }

    return Container(
                decoration: decoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        item.timeStamp,
                        style: const TextStyle(
                          fontSize: 16.0, 
                          fontWeight: FontWeight.bold
                        )
                      ), 
                    ),
                    Divider(
                      height: 2.0,
                      thickness: 1.0,
                      color: borderColor,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${item.type} : ${item.value}",
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              );
  }

}

//Widget for displaying scanned data, but formatted to be in a list and with a ontap method.
class ScannedItem extends ScannedItemBase {

  //UI data.
  final int number;

  //Controllers.
  final void Function()? onTap;
  const ScannedItem({super.key, required super.item, required this.number, required this.onTap});

  //TODO add some color to the row.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
      Container(
        //margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        //padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: borderColor, // Border color
            width: borderWidth,
          ),
        ),
        child: 
          Row(children: [
            const SizedBox(width: 8,),
            Container(
              
              //color: Colors.blueAccent,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor, // Border color
                  width: borderWidth,
                ),
              ),
              child: 
                Text(
                  '$number',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
            ),
            const SizedBox(width: 8,),
            Expanded( //We dont want to use full border here since the wrapping container handles this here.
              child: ScannedItemData(item: item, fullBorder: false,),
            ),        
        ],)
      )
    );
  }
}