class PositionMaxMinAvg {
  final int position;
  final double max;
  final double min;
  final double avg;
  final double max2;
  final double min2;
  final double avg2;
  final int count;

  PositionMaxMinAvg({
    required this.position,
    this.max = 0.0,
    this.min = 0.0,
    this.avg = 0.0,
    this.max2 = 0.0,
    this.min2 = 0.0,
    this.avg2 = 0.0,
    this.count = 0,
  });

  @override
  String toString() {
    return 'PositionMaxMinAvg(position: $position, max: $max, min: $min, avg: $avg, count: $count)';
  }
}
