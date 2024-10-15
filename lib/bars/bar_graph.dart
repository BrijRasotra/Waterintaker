import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_intaker/bars/bar_data.dart';
import 'package:water_intaker/bars/individual%20bars.dart';
import 'package:water_intaker/data/waterData.dart';

class BarGraph extends StatelessWidget {
  final double maxy;
  final double sunWaterAmount;
  final double monWaterAmount;
  final double tueWaterAmount;
  final double wedWaterAmount;
  final double thuWaterAmount;
  final double friWaterAmount;
  final double satWaterAmount;

  BarGraph(
      {super.key,
      required this.maxy,
      required this.sunWaterAmount,
      required this.monWaterAmount,
      required this.tueWaterAmount,
      required this.wedWaterAmount,
      required this.thuWaterAmount,
      required this.friWaterAmount,
      required this.satWaterAmount});

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
        sunWaterAmount: sunWaterAmount,
        monWaterAmount: monWaterAmount,
        tueWaterAmount: tueWaterAmount,
        wedWaterAmount: wedWaterAmount,
        thusWaterAmount: thuWaterAmount,
        friWaterAmount: friWaterAmount,
        satWaterAmount: satWaterAmount);
    barData.initBarData();

    return BarChart(BarChartData(
        maxY: maxy,
        minY: 0,
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitleWidget))),
        barGroups: barData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.lightGreen[900],
                      width: 23,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: maxy, color: Colors.grey[300]))
                ]))
            .toList()));
  }

  Widget getBottomTitleWidget(double value, TitleMeta meta) {
    TextStyle style = const TextStyle(
        color: Color.fromARGB(255, 24, 23, 23),
        fontWeight: FontWeight.bold,
        fontSize: 12);
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text(
          'S',
          style: style,
        );
        break;
      case 1:
        text = Text(
          'M',
          style: style,
        );
        break;
      case 2:
        text = Text(
          'T',
          style: style,
        );
        break;
      case 3:
        text = Text(
          'W',
          style: style,
        );
        break;
      case 4:
        text = Text(
          'T',
          style: style,
        );
        break;
      case 5:
        text = Text(
          'F',
          style: style,
        );
        break;
      case 6:
        text = Text(
          'S',
          style: style,
        );
        break;
      default:
        text = Text(
          ' ',
          style: style,
        );
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: text,
    );
  }

}
