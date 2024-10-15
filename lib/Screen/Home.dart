import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_intaker/Screen/components/water_intaker_summary.dart';
import 'package:water_intaker/data/waterData.dart';
import 'package:water_intaker/model/water_model.dart';

import 'components/about_Screen.dart';
import 'components/setting_screen.dart';
import 'components/waterTile.dart';

class Home extends StatelessWidget {
  final amountController = TextEditingController();
  WaterData waterController = Get.put(WaterData(), permanent: true);
  bool _isLoad = false;

  void loadData() async {
    waterController.getList().then((water) {
      if (water.isNotEmpty) {
        _isLoad = false;
        waterController.update();
      } else {
        _isLoad = true;
        waterController.update();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return GetBuilder<WaterData>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                    '${controller.calculateWeeklyIntakeWater(controller)} ml'),
                centerTitle: true,
                actions: const [
                  Icon(Icons.map),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: !_isLoad
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: WaterIntakeSummary(
                            startOfweek: waterController.getStartOfWeek(),
                          ),
                        ),
                        !_isLoad
                            ? WaterTile(waterModal: waterController)
                            : Center(
                                child: CircularProgressIndicator(),
                              )
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  addWater(context);
                  amountController.clear();
                },
                child: const Icon(Icons.add),
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Text(
                        "Water Intake Go",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    ListTile(
                      title: Text("Setting"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("About"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutScreen()));
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  void addWater(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Water"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add water to your daily intake"),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Amount'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                saveData(context);
                Get.back();
              },
              child: const Text("Save")),
        ],
      ),
    );
  }

  void saveData(BuildContext context) async {
    waterController!.saveData(WaterModel(
        amount: double.parse(amountController.text),
        dateTime: DateTime.now(),
        unit: 'ml'));

    if (!context.mounted) {
      return;
    }
  }
}
