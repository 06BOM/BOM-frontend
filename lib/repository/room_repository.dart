import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/room.dart';

// http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/room/search?search=피그
// http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com/room/all

class RoomRepository{
  static const urlApi =
      'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';

  // Future<List<Room>> loadOwnedCharacter() async {
  //   print('Fetch loadOwnedCharacter data...');
  //   var url = Uri.parse(urlApi + '/character/user/collection?userId=1');
  //   var response = await http.get(url);
  //   print('${response.body} in loadOwnedCharacter');
  //   if (response.body == null) {
  //     print('error with get');
  //   }
  //   if (response.statusCode == 200 || response.statusCode == 201) { // CI/ CD이후 변경하기
  //     Map<String, dynamic> body = json.decode(response.body);
  //     print('body => $body');
  //     if (body['characters'] == null) {
  //       print('error because user\'s character is empty');
  //     }
  //     List<dynamic> list = body['characters'];
  //     return list.map<Character>((charcater) => Character.fromJson(charcater)).toList();
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //     throw Exception('Can\'t get users character');
  //   }
  // }
}