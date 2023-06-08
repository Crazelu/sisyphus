import 'dart:convert';
import 'dart:async' show Timer;
import 'dart:io';
import 'dart:math' show Random;
import 'package:sissyphus/utils/app_strings.dart';
import 'package:sissyphus/utils/logger.dart';

class SocketService {
  SocketService() {
    _init();
  }

  late final _logger = Logger(SocketService);
  WebSocket? _socket;
  late final _random = Random();

  int _retryCount = 0;
  static const _maxRetries = 5;

  void _init() async {
    String key =
        base64.encode(List<int>.generate(8, (_) => _random.nextInt(256)));

    final client = HttpClient();

    final request = await client.getUrl(Uri.parse(AppStrings.socketUrl));

    request.headers.add('Connection', 'upgrade');
    request.headers.add('Upgrade', 'websocket');
    request.headers.add('sec-websocket-version', '13');
    request.headers.add('sec-websocket-key', key);

    _logger.log("Set headers");

    final response = await request.close();

    _logger.log("Got response -> ${response.statusCode} ${response.headers}");

    if (response.statusCode != 101) {
      _retryCount++;
      if (_retryCount < _maxRetries) _init();
      return;
    }

    final socket = await response.detachSocket();

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
  final List<Function> _tasks = [];

  void _scheduleTask(Function callback) {
    _tasks.add(callback);
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if ((_socket?.readyState ?? 0) == 1) {
          timer.cancel();
          for (var task in _tasks) {
            task();
          }
          _tasks.clear();
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
    _timer?.cancel();
  }
}
