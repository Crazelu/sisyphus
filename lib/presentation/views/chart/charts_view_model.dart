import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/data/repositories/kline_repository.dart';
import 'package:sissyphus/data/services/socket_service.dart';
import 'package:sissyphus/models/kline_candle.dart';
import 'package:sissyphus/utils/app_strings.dart';
import 'package:sissyphus/utils/logger.dart';

final chartsViewModelProvider = Provider<ChartsViewModel>(
  (ref) => ChartsViewModel(),
);

class ChartsViewModel {
  ChartsViewModel() {
    // _init();
  }

  late final _logger = Logger(ChartsViewModel);

  late final _klineRepo = KlineRepository();
  late final _socketService = SocketService();
  final String _pair = AppStrings.pair;

  late String _currentInterval = _intervals.first.toLowerCase();
  String get currentKlineInterval => _currentInterval;

  final List<String> _intervals = const [
    "1H",
    "2H",
    "4H",
    "1D",
    "1W",
    "1M",
  ];
  List<String> get intervals => _intervals;

  List<KlineCandle> _olderCandles = [];

  late final ValueNotifier<List<KlineCandle>> _candles = ValueNotifier([]);
  ValueNotifier<List<KlineCandle>> get candles => _candles;

  bool _hasFetchedOlderCandles = false;
  DateTime? _endTime;

  String get _subscriptionParam => "$_pair@kline_$_currentInterval";

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([_subscriptionParam]);
    _endTime = DateTime.now();
  }

  Future<void> _fetchOlderCandles() async {
    try {
      if (_hasFetchedOlderCandles) return;
      _olderCandles = await _klineRepo.fetchOlderCandles(
        symbol: _pair,
        interval: _currentInterval,
        endTime: _endTime,
      );
      _hasFetchedOlderCandles = true;
    } catch (e) {
      _logger.log(e);
    }
  }

  void updateInterval(String interval) {
    _candles.value = [];
    _appendOlderCandles();
    final oldIntervalSubscription = _subscriptionParam;

    _currentInterval =
        interval == _intervals.last ? interval : interval.toLowerCase();
    _socketService.subscribe([_subscriptionParam]);
    _hasFetchedOlderCandles = false;
    _endTime = DateTime.now();
    _socketService.unsubscribe([oldIntervalSubscription]);
  }

  void _appendOlderCandles() {
    if (_olderCandles.isNotEmpty) {
      _candles.value = [..._candles.value, ..._olderCandles.reversed];
      _olderCandles = [];
    }
  }

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    if (eventType == "kline" && data["k"]["i"] == _currentInterval) {
      _fetchOlderCandles();
      final newCandleData = KlineCandle.fromJson(data);

      if (_candles.value.isNotEmpty) {
        final lastCandle = _candles.value.first;
        final candles = _candles.value;

        KlineCandle updatedCandle;

        if (lastCandle.date == newCandleData.date && !lastCandle.closed) {
          updatedCandle = lastCandle.update(newCandleData);
          candles.removeAt(0);
          _candles.value = [updatedCandle, ...candles];
        } else {
          _candles.value = [newCandleData, ...candles];
        }
      } else {
        _candles.value = [newCandleData];
      }

      _appendOlderCandles();
    }
  }

  void dispose() {
    _socketService.dispose();
    _candles.dispose();
  }
}
