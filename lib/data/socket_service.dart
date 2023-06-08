import 'dart:convert';
import 'dart:async' show Timer;
import 'dart:io';
import 'dart:math' show Random;
import 'package:sissyphus/utils/logger.dart';

class SocketService {
  final String baseUrl;

  SocketService(this.baseUrl) {
    _setup();
  }

  late final _logger = Logger(SocketService);
  WebSocket? _socket;
  late final _random = Random();

  int _retryCount = 0;
  static const _maxRetries = 5;

  void _setup() async {
    Random r = Random();
    String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(256)));

    HttpClient client = HttpClient();

    HttpClientRequest request = await client.getUrl(Uri.parse(baseUrl));

    request.headers.add('Connection', 'upgrade');
    request.headers.add('Upgrade', 'websocket');
    request.headers.add('sec-websocket-version', '13');
    request.headers.add('sec-websocket-key', key);

    _logger.log("Set headers");

    HttpClientResponse response = await request.close();

    _logger.log("Got response -> ${response.statusCode} ${response.headers}");

    if (response.statusCode != 101) {
      _retryCount++;
      if (_retryCount < _maxRetries) _setup();
      return;
    }

    Socket socket = await response.detachSocket();

    _socket = WebSocket.fromUpgradedSocket(
      socket,
      serverSide: false,
    );

    _socket?.listen((data) {
      try {
        final json = jsonDecode(data);
        if (json["data"] != null) {
          _logger.log("GOT DATA: ${json["data"]}");
          _listener?.call(json["data"]);
        }
      } catch (e) {
        _logger.log(e);
      }
    });
  }

  Function(Map<String, dynamic>)? _listener;

  void attachListener(Function(Map<String, dynamic>) listener) {
    _listener = listener;
  }

  Timer? _timer;

  void _scheduleTask(Function callback) {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if ((_socket?.readyState ?? 0) == 1) {
          callback();
          timer.cancel();
        }
      },
    );
  }

  void subscribe(List<String> channels) async {
    _scheduleTask(() {
      _logger.log("SUBSCRIBING TO $channels");
      _socket?.add(
        jsonEncode(
          {
            "method": "SUBSCRIBE",
            "params": channels,
            "id": _random.nextInt(100),
          },
        ),
      );
    });
  }

  void unsubscribe(List<String> channels) {
    _scheduleTask(() {
      _logger.log("UNSUBSCRIBING FROM $channels");
      _socket?.add(
        jsonEncode(
          {
            "method": "UNSUBSCRIBE",
            "params": channels,
            "id": _random.nextInt(100),
          },
        ),
      );
    });
  }

  void dispose() {
    _socket?.close();
  }
}
