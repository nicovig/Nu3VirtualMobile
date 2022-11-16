class MonitoringModel {
  int? carbohydrate;
  int? lipid;
  int? protein;
  int? caloriesConsumed;
  int? caloriesBurned;

  MonitoringModel(
      {this.carbohydrate,
      this.lipid,
      this.protein,
      this.caloriesConsumed,
      this.caloriesBurned});

  factory MonitoringModel.fromJson(Map<String, dynamic> parsedJson) {
    return MonitoringModel(
        carbohydrate: parsedJson["carbohydrate"],
        lipid: parsedJson["lipid"],
        protein: parsedJson["protein"],
        caloriesConsumed: parsedJson["caloriesConsumed"],
        caloriesBurned: parsedJson["caloriesBurned"]);
  }
}
