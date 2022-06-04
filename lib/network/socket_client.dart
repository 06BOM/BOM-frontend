import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient{ // single tone pattern
  late IO.Socket socket;
  static late SocketClient _instance;

  SocketClient._internal(){ // initializeSocket
    //무선 LAN 어댑터 Wi-Fi: IPv4

    // socket = IO.io('http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com', <String, dynamic>{
    socket = IO.io('http://192.168.0.14:3000', <String, dynamic>{ // http://localhost:3000 (X)
    // socket = IO.io('localhost:3000', <String, dynamic>{ // http://localhost:3000 (X)
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  static SocketClient get instance{
    _instance = SocketClient._internal();
    return _instance;
  }
}

// class SocketClient{ // single tone pattern
//   IO.Socket? socket;
//   static SocketClient? _instance;
//
//   SocketClient._internal(){ // initializeSocket
//     //무선 LAN 어댑터 Wi-Fi: IPv4
//     socket = IO.io('http://192.168.0.14:3000', <String, dynamic>{ // http://localhost:3000 (X)
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//     socket!.connect();
//   }
//
//   static SocketClient get instance{
//     _instance ??= SocketClient._internal();
//     return _instance!;
//   }
// }