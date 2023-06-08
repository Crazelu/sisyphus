import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/data/socket_service.dart';
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
  String _currentKlineInterval = "1d";

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "$_pair@kline_$_currentKlineInterval",
    ]);
  }

  void updateKlineInterval(String interval) {
    _socketService.unsubscribe(["$_pair@kline_$_currentKlineInterval"]);
    _currentKlineInterval = interval.toLowerCase();
    _socketService.subscribe(["$_pair@kline_$_currentKlineInterval"]);
  }

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    if (eventType == "kline") {}
  }

  void dispose() {
    _socketService.dispose();
  }
}
