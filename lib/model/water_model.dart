class WaterModel {
  String? id;
  double? amount;
  DateTime? dateTime;

  WaterModel(
      {this.id,
      required this.amount,
      required this.dateTime,
      required String unit});

  factory WaterModel.fromJson(Map<String, dynamic> map, String id) =>
      WaterModel(
          id: id,
          amount: map['amount'],
          dateTime: DateTime.parse(map['dateTime']),
          unit: map['unit']);

  Map<String, dynamic> toJson() {
    return {"amount": amount, "dateTime": DateTime.now()};
  }
}
