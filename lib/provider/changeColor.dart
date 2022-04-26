import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeColor extends ChangeNotifier
{
  List colors= [ Colors.red,
    Colors.green,
    Colors.blue,
    Colors.grey,
    Colors.deepOrange,
    Colors.blue.shade900,
    Colors.brown,
    Colors.brown.shade900,
    Colors.pink.shade900
  ];

  Color? selectedColor;
  changeColor(int i)

  {
    selectedColor= colors[i];
    notifyListeners();
  }

}