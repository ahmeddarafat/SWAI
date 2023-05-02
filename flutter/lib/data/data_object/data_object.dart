class RateDataObject {
  final String title;
  final int measurement;
  final String unit;
  final double avg;
  final double min;
  final double max;
  final double maxRange;
  final double minRange;
  final double interval;

  RateDataObject({
    required this.title,
    required this.measurement,
    required this.unit,
    required this.avg,
    required this.min,
    required this.max,
    required this.maxRange,
    required this.minRange,
    required this.interval,

  });
}

class RateData {
  RateData(this.time, this.number);
  final DateTime time;
  final double number;
}
