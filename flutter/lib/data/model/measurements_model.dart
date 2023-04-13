class MeasurementsModel {
  final double heartRate;
  final double temperature;
  final double oxygenRate;
  final double glucoseRate;

  MeasurementsModel({
    required this.heartRate,
    required this.temperature,
    required this.oxygenRate,
    required this.glucoseRate,
  });

  factory MeasurementsModel.fromJson(Map<String, dynamic> json) {
    return MeasurementsModel(
      heartRate: json['heart_rate'],
      temperature: json['temperature'],
      oxygenRate: json['oxygen_rate'],
      glucoseRate: json['glucose_rate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['heart_rate'] = heartRate;
    data['temperature'] = temperature;
    data['oxygen_rate'] = oxygenRate;
    data['glucose_rate'] = glucoseRate;
    return data;
  }
}
