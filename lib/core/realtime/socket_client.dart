import 'package:socket_io_client/socket_io_client.dart' as io;

typedef SocketCallback = void Function(dynamic data);

class SocketClient {
  SocketClient({required String url}) {
    _socket = io.io(url, {
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    });
  }

  late final io.Socket _socket;

  io.Socket get raw => _socket;

  void connect({Map<String, dynamic>? auth}) {
    if (auth != null) _socket.auth = auth;
    _socket.connect();
  }

  void disconnect() => _socket.disconnect();

  void on(String event, SocketCallback callback) => _socket.on(event, callback);
  void off(String event, [SocketCallback? cb]) => _socket.off(event, cb);
  void emit(String event, dynamic data) => _socket.emit(event, data);
}
