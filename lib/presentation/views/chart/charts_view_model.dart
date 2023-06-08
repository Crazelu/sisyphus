import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/data/socket_service.dart';
import 'package:sissyphus/models/kline_candle.dart';
import 'package:sissyphus/utils/app_strings.dart';

final chartsViewModelProvider = Provider<ChartsViewModel>(
  (ref) => ChartsViewModel(),
);

class ChartsViewModel {
  ChartsViewModel() {
    _init();
  }

  late final _socketService = SocketService();
  final String _pair = AppStrings.pair;
  String _currentKlineInterval = "1m";

  late final ValueNotifier<List<KlineCandle>> _candles = ValueNotifier([]);
  ValueNotifier<List<KlineCandle>> get candles => _candles;

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "$_pair@kline_$_currentKlineInterval",
    ]);
  }

  void updateKlineInterval(String interval) {
    _candles.value = [];
    _normalizeCandleCount();
    _socketService.unsubscribe(["$_pair@kline_$_currentKlineInterval"]);
    _currentKlineInterval = interval.toLowerCase();
    _socketService.subscribe(["$_pair@kline_$_currentKlineInterval"]);
  }

  void _normalizeCandleCount() {
    final length = _candles.value.length;
    if (length < 14) {
      final defaultCandles = List.generate(
        14 - length,
        (index) => length == 0
            ? KlineCandle.noop()
            : _candles.value.last.copyWith(closed: true),
      );

      _candles.value = [..._candles.value, ...defaultCandles];
    }
  }

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    if (eventType == "kline") {
      final newCandleData = KlineCandle.fromJson(data);

      if (_candles.value.isNotEmpty) {
        final lastCandle = _candles.value.last;
        final candles = _candles.value;

        KlineCandle updatedCandle;

        if (lastCandle.date == newCandleData.date) {
          updatedCandle = lastCandle.update(newCandleData);
          candles.removeLast();
          _candles.value = [updatedCandle, ...candles];
        } else {
          _candles.value = [newCandleData, ...candles];
        }
      } else {
        _candles.value = [newCandleData];
      }

      _normalizeCandleCount();
    }
  }

  void dispose() {
    _socketService.dispose();
  }
}
