import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Blue', percent: 25, color: Colors.grey),
    Data(name: 'Orange', percent: 25, color: Colors.grey),
    Data(name: 'Black', percent: 25, color: Colors.grey),
    Data(name: 'Green', percent: 25, color: Colors.grey),
  ];

  static List<Data> bigData = [
    Data(name: 'Blue', percent: 25, color: Colors.grey),
    Data(name: 'Orange', percent: 25, color: Colors.grey),
    Data(name: 'Black', percent: 25, color: Colors.grey),
    Data(name: 'Green', percent: 25, color: Colors.grey),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({@required this.name, @required this.percent, @required this.color});
}
