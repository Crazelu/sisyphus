import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/data/socket_service.dart';
import 'package:sissyphus/models/order.dart';
import 'package:sissyphus/models/trade_data.dart';
import 'package:sissyphus/utils/logger.dart';

final tradeDetailsViewModelProvider = Provider<TradeDetailsViewModel>(
  (ref) => TradeDetailsViewModel(),
);

class TradeDetailsViewModel {
  TradeDetailsViewModel() {
    _init();
  }

  late final _logger = Logger(TradeDetailsViewModel);

  late final _socketService =
      SocketService("https://stream.binance.com/stream");
  static const String _symbol = "BTC/USDT";
  final String _pair = "btcusdt";
  String _currentKlineInterval = "1d";

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "$_pair@miniTicker",
      "$_pair@aggtrade",
      "$_pair@kline_$_currentKlineInterval",
    ]);
  }

  void updateKlineInterval(String interval) {
    _socketService.unsubscribe(["$_pair@kline_$_currentKlineInterval"]);
    _currentKlineInterval = interval.toLowerCase();
    _socketService.subscribe(["$_pair@kline_$_currentKlineInterval"]);
  }

  final ValueNotifier<String> _currentPrice = ValueNotifier("0");
  ValueNotifier<String> get currentPrice => _currentPrice;

  final ValueNotifier<List<Order>> _orders = ValueNotifier([]);
  ValueNotifier<List<Order>> get orders => _orders;

  final ValueNotifier<List<Order>> _buyOrders = ValueNotifier([]);
  ValueNotifier<List<Order>> get buyOrders => _buyOrders;

  final ValueNotifier<List<Order>> _sellOrders = ValueNotifier([]);
  ValueNotifier<List<Order>> get sellOrders => _sellOrders;

  final ValueNotifier<TradeData> _tradeData =
      ValueNotifier(TradeData.initial(_symbol));
  ValueNotifier<TradeData> get tradeData => _tradeData;

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    switch (eventType) {
      case "kline":
        break;
      case "24hrMiniTicker":
        data["symbol"] = _symbol;
        final newTradeData = TradeData.fromJson(data);
        _tradeData.value = newTradeData;
        break;
      case "aggTrade":
        final order = Order.fromJson(data);
        _orders.value = [..._orders.value, order];
        if (order.isBuy) {
          _buyOrders.value = [..._buyOrders.value, order];
        } else {
          _sellOrders.value = [..._sellOrders.value, order];
        }
        break;
      default:
    }
  }

  void dispose() {
    _socketService.dispose();
  }
}
