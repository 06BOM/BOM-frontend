import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../address/test_address.dart';

class SocketClient{ // single tone pattern
  late IO.Socket socket;
  static late SocketClient _instance;

  SocketClient._internal(){ // initializeSocket
    //무선 LAN 어댑터 Wi-Fi: IPv4

    socket = IO.io('http://$conntectIp', <String, dynamic>{ // http://localhost:3000 (X)
      'transports': ['websocket'],
      'autoConnect': false,
    });
    print('socket connect!!');
    socket.connect();
  }

  static SocketClient get instance{
    _instance = SocketClient._internal();
    return _instance;
  }
}