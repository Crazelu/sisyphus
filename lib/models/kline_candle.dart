class KlineCandle {
  final double open;
  final double close;
  final double high;
  final double low;
  final double baseAssetVolume;
  final double quoteAssetVolume;
  final DateTime date;
  final bool closed;

  KlineCandle({
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.baseAssetVolume,
    required this.quoteAssetVolume,
    required this.date,
    this.closed = false,
  });

  factory KlineCandle.noop() {
    return KlineCandle(
      open: 0,
      close: 0,
      high: 0,
      low: 0,
      baseAssetVolume: 0,
      quoteAssetVolume: 0,
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
      baseAssetVolume: double.tryParse(data["v"]) ?? 0,
      quoteAssetVolume: double.tryParse(data["q"]) ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(data["t"]),
      closed: data["x"] ?? false,
    );
  }

  factory KlineCandle.fromList(List data) {
    return KlineCandle(
      open: double.tryParse(data[1]) ?? 0,
      close: double.tryParse(data[4]) ?? 0,
      high: double.tryParse(data[2]) ?? 0,
      low: double.tryParse(data[3]) ?? 0,
      baseAssetVolume: double.tryParse(data[5]) ?? 0,
      quoteAssetVolume: double.tryParse(data[7]) ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(data[0]),
      closed: true,
    );
  }

  KlineCandle update(KlineCandle other) {
    return KlineCandle(
      open: other.open,
      close: other.close,
      high: other.high > high ? other.high : high,
      low: other.low < low ? other.low : low,
      baseAssetVolume: other.baseAssetVolume,
      quoteAssetVolume: other.quoteAssetVolume,
      date: date,
    );
  }

  KlineCandle copyWith({
    double? open,
    double? close,
    double? high,
    double? low,
    double? baseAssetVolume,
    double? quoteAssetVolume,
    DateTime? date,
    bool? closed,
  }) {
    return KlineCandle(
      open: open ?? this.open,
      close: close ?? this.close,
      high: high ?? this.high,
      low: low ?? this.low,
      baseAssetVolume: baseAssetVolume ?? this.baseAssetVolume,
      quoteAssetVolume: quoteAssetVolume ?? this.quoteAssetVolume,
      date: date ?? this.date,
      closed: closed ?? this.closed,
    );
  }
}
