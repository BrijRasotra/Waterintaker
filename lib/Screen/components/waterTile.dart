import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/waterData.dart';

class WaterTile extends StatelessWidget {
  WaterTile({super.key, required this.waterModal});

  var waterModal;
  WaterData waterData = Get.put(WaterData());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final waterModel = waterModal.waterDetailList[index];

        return Card(
          color: Theme.of(context).colorScheme.primaryFixed,
          elevation: 4,
          child: ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: Colors.blue,
                  size: 20,
                ),
                Text(
                  " ${waterModel.amount!.toStringAsFixed(2)} ml",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Text(
                "${waterModel.dateTime!.day}/${waterModel.dateTime!.month}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                waterData.delete(waterModel);
              },
            ),
          ),
        );
      },
      itemCount: waterModal.waterDetailList.length,
    );
  }
}
