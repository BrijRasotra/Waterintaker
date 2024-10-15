import 'package:flutter/cupertino.dart';
import 'package:water_intaker/bars/bar_graph.dart';
import 'package:water_intaker/data/waterData.dart';
import 'package:get/get.dart';
import 'package:water_intaker/utils/date_helper.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfweek;

  WaterIntakeSummary({super.key, required this.startOfweek});

  double calculateMaxAmount(
      WaterData waterData,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? maxAmount = 100;
    List<double> values = [
      waterData.dailyWaterSummery()[sunday] ?? 0,
      waterData.dailyWaterSummery()[monday] ?? 0,
      waterData.dailyWaterSummery()[tuesday] ?? 0,
      waterData.dailyWaterSummery()[wednesday] ?? 0,
      waterData.dailyWaterSummery()[thursday] ?? 0,
      waterData.dailyWaterSummery()[friday] ?? 0,
      waterData.dailyWaterSummery()[saturday] ?? 0,
    ];
    //sort from smallest to largest
    values.sort();
    //get the largest value
    //increase the max amount
    maxAmount = values.last * 1.3;
    return maxAmount == 0 ? 100 : maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    final waterData = Get.put(WaterData());
    String sunday = convertDateTimetoString(startOfweek.add(Duration(days: 0)));
    String monday = convertDateTimetoString(startOfweek.add(Duration(days: 1)));
    String tuesday =
        convertDateTimetoString(startOfweek.add(Duration(days: 2)));
    String wednesday =
        convertDateTimetoString(startOfweek.add(Duration(days: 3)));
    String thursday =
        convertDateTimetoString(startOfweek.add(Duration(days: 4)));
    String friday = convertDateTimetoString(startOfweek.add(Duration(days: 5)));
    String saturday =
        convertDateTimetoString(startOfweek.add(Duration(days: 6)));

    return SizedBox(
      height: 200,
      child: BarGraph(
          maxy: calculateMaxAmount(waterData, sunday, monday, tuesday,
              wednesday, thursday, friday, saturday),
          sunWaterAmount: waterData.dailyWaterSummery()[sunday] ?? 0,
          monWaterAmount: waterData.dailyWaterSummery()[monday] ?? 0,
          tueWaterAmount: waterData.dailyWaterSummery()[tuesday] ?? 0,
          wedWaterAmount: waterData.dailyWaterSummery()[wednesday] ?? 0,
          thuWaterAmount: waterData.dailyWaterSummery()[thursday] ?? 0,
          friWaterAmount: waterData.dailyWaterSummery()[friday] ?? 0,
          satWaterAmount: waterData.dailyWaterSummery()[saturday] ?? 0),
    );
  }
}
