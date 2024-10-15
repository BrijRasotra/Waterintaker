import 'dart:convert';
import 'package:get/get.dart';
import 'package:water_intaker/model/water_model.dart';
import 'package:http/http.dart' as http;

import '../utils/date_helper.dart';

class WaterData extends GetxController {
  List<WaterModel> waterDetailList = [];

  ///add water
  void saveData(WaterModel model) async {
    Map<String, dynamic> map = {
      "amount": double.parse(model.amount.toString()),
      "unit": "ml",
      "time": DateTime.now().toString()
    };

    print(map);
    final url = Uri.https(
        'water-intaker-25920-default-rtdb.firebaseio.com', 'water.json');
    print("object999");
    var response = await http
        .post(url,
            headers: {'content-Type': 'application/json'},
            body: json.encode(map))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 400);
    });
    update();
    if (response.statusCode == 200) {
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      waterDetailList.add(WaterModel(
          amount: model.amount, dateTime: model.dateTime, unit: 'ml'));
    } else {
      print("Error:${response.statusCode}");
    }
  }

  Future<List<WaterModel>> getList() async {
    final url = Uri.https(
        'water-intaker-25920-default-rtdb.firebaseio.com', 'water.json');
    final response = await http.get(url);
    if (response.statusCode == 200 && response.statusCode != null) {
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      List<WaterModel> tempList = extractedData.entries.map((element) {
        return WaterModel(
          id: element.key,
          amount: element.value['amount'],
          dateTime: DateTime.parse(element.value['time']),
          unit: element.value['unit'],
        );
      }).toList();
      waterDetailList.clear();
// Now add all the items to waterDetailList
      waterDetailList.addAll(tempList);
    }
    print(waterDetailList);
    update();
    return waterDetailList;
  }

  void delete(WaterModel waterModel) {
    final url = Uri.https('water-intaker-25920-default-rtdb.firebaseio.com',
        'water/${waterModel.id}.json');
    http.delete(url);
    waterDetailList.removeWhere((e) => e.id == waterModel.id);
    update();
  }

  DateTime getStartOfWeek() {
    DateTime? startOfWeek;
    //get the current date
    DateTime dateTime = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getWeekDay(dateTime.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = dateTime.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  //get week day from dateTime obj
  String getWeekDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thus';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  ///calculate the weekly water intake
  String calculateWeeklyIntakeWater(WaterData value) {
    double weeklyWaterIntake = 0;

    for (var water in value.waterDetailList) {
      weeklyWaterIntake += double.parse(water.amount.toString());
    }
    return weeklyWaterIntake.toStringAsFixed(2);
  }

  /// calculate the daily water intake
  Map<String, dynamic> dailyWaterSummery() {
    Map<String, double> dailywater = {};

    //loop through the water data list
    for (var water in waterDetailList) {
      String date = convertDateTimetoString(water.dateTime!);
      double amount = double.parse(water.amount.toString());
      print(amount);

      if (dailywater.containsKey(date)) {
        double currentAmount = dailywater[date]!;
        currentAmount += amount;
        dailywater[date] = currentAmount;
      } else {
        dailywater.addAll({date: amount});
      }
    }
    return dailywater;
  }

}
