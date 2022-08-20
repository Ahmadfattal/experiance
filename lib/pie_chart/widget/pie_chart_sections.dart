
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/pie_data.dart';

List<PieChartSectionData> getSections( int touchedIndex, Color? color) => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 70 : 60;
      final Color? coloredIndex= isTouched ? color:data.color;

      final value = PieChartSectionData(
        color:coloredIndex,
        value: data.percent,
        title: '${data.percent}',
        radius: radius,

        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      return MapEntry(index, value);
    })
    .values
    .toList();



List<PieChartSectionData> getMaxSections(int touchedIndex,Color? color) => PieData.bigData
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
  final isTouched = index == touchedIndex;
  final double fontSize = isTouched ? 25 : 16;
  final double radius = isTouched ? 70 : 60;
  final Color? coloredIndex= isTouched ? color:data.color;

  final value = PieChartSectionData(
    color: coloredIndex,
    value: data.percent,
    title: '${data.percent}',
    radius: radius,
    titleStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: const Color(0xffffffff),
    ),
  );

  return MapEntry(index, value);
})
    .values
    .toList();

