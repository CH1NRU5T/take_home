import 'package:flutter/material.dart';

class Beer {
  final String brand, name, alcohol;
  late Color color;
  Beer({required this.brand, required this.name, required this.alcohol}) {
    color = getColor(double.parse(alcohol.substring(0, alcohol.length - 1)));
  }

  Color getColor(double alcohol) {
    return alcohol < 5 ? Colors.green : Colors.red;
  }
}
