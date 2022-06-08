import 'dart:convert';
import 'package:http/http.dart' as http;
import '../address/local_address.dart';
import '../model/room.dart';

// http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/room/search?search=피그
// http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/room/all

class RoomRepository{
  static const urlApi = 'http://$localAddress:3000';
      // 'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';
  Future<List<Room>> loadAllRooms() async {
    print('Fetch loadAllRoom data...');
    var url = Uri.parse(urlApi + '/room/all');
    var response = await http.get(url);
    print('${response.body} in loadAllRoom');
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      // print('body => $body');
      if (body['resultRoom'] == null) {
        print('error because all room is empty');
      }
      List<dynamic> list = body['resultRoom'];
      return list.map<Room>((room) => Room.fromJson(room)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get users room');
    }
  }

  Future<List<Room>> searchRoom() async {
    print('Fetch searchRoom data...');
    var url = Uri.parse(urlApi + '/room/search?search=피그');
    var response = await http.get(url);
    print('${response.body} in searchRoom');
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('body => $body');
      if (body['resultRoom'] == null) {
        print('error because all room is empty');
      }
      List<dynamic> list = body['resultRoom'];
      return list.map<Room>((room) => Room.fromJson(room)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get users room');
    }
  }
}