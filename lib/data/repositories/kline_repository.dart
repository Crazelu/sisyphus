import 'package:sissyphus/data/services/http_service.dart';
import 'package:sissyphus/models/kline_candle.dart';

class KlineRepository {
  late final HttpService _httpService = HttpService();

  Future<List<KlineCandle>> fetchOlderCandles({
    required String symbol,
    required String interval,
    int limit = 500,
    DateTime? endTime,
  }) async {
    String path =
        "klines?symbol=${symbol.toUpperCase()}&interval=$interval&limit=$limit";

    if (endTime != null) {
      path += "&endTime=${endTime.millisecondsSinceEpoch}";
    }

    final response = await _httpService.get(path: path);

    if (response.hasError) return [];

    return List<KlineCandle>.from(
      response.body["data"].map(
        (e) => KlineCandle.fromList(e),
      ),
    );
  }
}
