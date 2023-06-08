class KlineCandle {
  final double open;
  final double close;
  final double high;
  final double low;
  final double volume;
  final DateTime date;
  final bool closed;

  KlineCandle({
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.volume,
    required this.date,
    this.closed = false,
  });

  factory KlineCandle.noop() {
    return KlineCandle(
      open: 0,
      close: 0,
      high: 0,
      low: 0,
      volume: 0,
      date: DateTime.now(),
      closed: true,
    );
  }

  factory KlineCandle.fromJson(Map<String, dynamic> json) {
    final data = json["k"] ?? {};
    return KlineCandle(
      open: double.tryParse(data["o"]) ?? 0,
      close: double.tryParse(data["c"]) ?? 0,
      high: double.tryParse(data["h"]) ?? 0,
      low: double.tryParse(data["l"]) ?? 0,
      volume: double.tryParse(data["v"]) ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(data["t"]),
      closed: data["x"] ?? false,
    );
  }

  KlineCandle update(KlineCandle other) {
    return KlineCandle(
      open: other.open,
      close: other.close,
      high: other.high > high ? other.high : high,
      low: other.low < low ? other.low : low,
      volume: other.volume,
      date: date,
    );
  }

  KlineCandle copyWith({
    double? open,
    double? close,
    double? high,
    double? low,
    double? volume,
    DateTime? date,
    bool? closed,
  }) {
    return KlineCandle(
      open: open ?? this.open,
      close: close ?? this.close,
      high: high ?? this.high,
      low: low ?? this.low,
      volume: volume ?? this.volume,
      date: date ?? this.date,
      closed: closed ?? this.closed,
    );
  }
}
