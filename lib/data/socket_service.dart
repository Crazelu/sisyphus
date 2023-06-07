import 'dart:convert';
import 'package:web_socket_client/web_socket_client.dart';

class SocketService {
  final String baseUrl;

  SocketService(this.baseUrl) {
    _init();
  }

  WebSocket? _socket;
  WebSocket? get socket => _socket;

  void _init() {
    final uri = Uri.parse(baseUrl);
    const backoff = ConstantBackoff(Duration(seconds: 1));
    _socket = WebSocket(uri, backoff: backoff);
    _socket?.messages.listen((message) {
      _listener?.call(jsonDecode(message));
    });
  }

  Function(Map<String, dynamic>)? _listener;

  void attachListener(Function(Map<String, dynamic>) listener) {
    _listener = listener;
  }

  void dispose() {
    _socket?.close();
  }
}
