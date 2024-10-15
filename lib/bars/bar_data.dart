import 'package:water_intaker/bars/individual%20bars.dart';

class BarData {
  final double sunWaterAmount;
  final double monWaterAmount;
  final double tueWaterAmount;
  final double wedWaterAmount;
  final double thusWaterAmount;
  final double friWaterAmount;
  final double satWaterAmount;

  BarData(
      {required this.sunWaterAmount,
      required this.monWaterAmount,
      required this.tueWaterAmount,
      required this.wedWaterAmount,
      required this.thusWaterAmount,
      required this.friWaterAmount,
      required this.satWaterAmount});

  List<IndividualBars> barData = [];

  void initBarData() {
    barData = [
      IndividualBars(x: 0, y: sunWaterAmount),
      IndividualBars(x: 1, y: monWaterAmount),
      IndividualBars(x: 2, y: tueWaterAmount),
      IndividualBars(x: 3, y: wedWaterAmount),
      IndividualBars(x: 4, y: thusWaterAmount),
      IndividualBars(x: 5, y: friWaterAmount),
      IndividualBars(x: 6, y: satWaterAmount),
    ];
  }
}
