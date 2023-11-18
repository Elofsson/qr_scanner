

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/utils.dart';

class Item {
  final String type;
  final String value;

  Item({required this.type, required this.value});

  bool isEmpty() {
    return type.isEmpty && value.isEmpty;
  }
}

class ScannedItem extends StatelessWidget {
  final Item item;
  final int number;
  final void Function()? onTap;
  const ScannedItem({super.key, required this.item, required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
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
        child: Column(
          children: [
            Text(
              "${item.type} : ${item.value}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Scanned at ${getTimestamp()}",
              style: const TextStyle(
                fontSize: 16.0, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 8.0),
            Text(
              'Number: $number',
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    );
  }
}