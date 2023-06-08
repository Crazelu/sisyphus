import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/data/services/socket_service.dart';
import 'package:sissyphus/models/trade_data.dart';
import 'package:sissyphus/utils/app_strings.dart';

final tradeDetailsViewModelProvider = Provider<TradeDetailsViewModel>(
  (ref) => TradeDetailsViewModel(),
);

class TradeDetailsViewModel {
  TradeDetailsViewModel() {
    _init();
  }

  late final _socketService = SocketService();
  static const String _symbol = AppStrings.symbol;
  final String _pair = AppStrings.pair;

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "$_pair@miniTicker",
    ]);
  }

  final ValueNotifier<TradeData> _tradeData =
      ValueNotifier(TradeData.initial(_symbol));
  ValueNotifier<TradeData> get tradeData => _tradeData;

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    if (eventType == "24hrMiniTicker") {
      data["symbol"] = _symbol;
      final newTradeData = TradeData.fromJson(data);
      _tradeData.value = newTradeData;
    }
  }

  void dispose() {
    _socketService.dispose();
  }
}
