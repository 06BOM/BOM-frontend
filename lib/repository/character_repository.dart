import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/character.dart';

class CharacterRepository{
  static const urlApi =
      'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';

  //해당 userid가 가지고 있는 모든 character들을 가져온다.
  Future<List<Character>> loadOwnedCharacter() async {
    print('Fetch loadOwnedCharacter data...');
    var url = Uri.parse(urlApi + '/character/user/collection?userId=1');
    var response = await http.get(url);
    print('${response.body} in loadOwnedCharacter');
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200 || response.statusCode == 201) { // CI/ CD이후 변경하기
      Map<String, dynamic> body = json.decode(response.body);
      print('body => $body');
      if (body['characters'] == null) {
        print('error because user\'s character is empty');
      }
      List<dynamic> list = body['characters'];
      return list.map<Character>((charcater) => Character.fromJson(charcater)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get users character');
    }
  }

  //해당 user id가 가지고 있지 않은 모든 character들을 획득
  Future<List<Character>> loadNotOwnedCharacter() async {
    print('Fetch loadNotOwnedCharacter data...');
    var url = Uri.parse(urlApi + 'character/user/want?userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('category.len => ${body['category'].length}');
      if (body['notHavingCharacterData'] == null) {
        print('error because user\'s not owned character is empty');
      }
      List<dynamic> list = body['notHavingCharacterData'];
      return list.map<Character>((charcater) => Character.fromJson(charcater)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get users not owned character');
    }
  }

// 해당 user의 캐릭터 콜랙션에 해당하는 character id 캐릭터를 추가한다 (POST)
  Future addCharacterInCollection(/*int? userId, {String? categoryName, String? color}*/) async {
    var url = Uri.parse(urlApi + '/character/user/collection?userId=1&characterId=4');
    var response = await http.post(url,
        headers: <String, String>{'Content-type': 'application/json'});
    if (response.body == null) {
      print('error with addCharacterInCollection response');
    }
    if (response.body.isNotEmpty) {
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

// 해당 user의 캐릭터 콜랙션에서 해당하는 character id 캐릭터를 삭제한다
  Future deleteCharacterInCollection(id) async {
    var url = Uri.parse(urlApi + '/character/user/collection?userId=1&characterId=4');
    var response = await http.delete(url);
    print('delete success!');
    if (response.statusCode >= 404) {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    } else {
      return true;
    }
  }

  // character id에 해당하는 캐릭터의 image url을 가져온다 (프로필 용도)

  Future<String> fetchCharacterImageUrl() async {
    print('Fetch fetchCharacterImageUrl data...');
    var url = Uri.parse(
        urlApi + '/character/imageurl?characterId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['character'] == null) {
        print('Error! because plan is empty');
      }
      print('${body['character']['imageUrl']} in character_repoistory');
      return body['character']['imageUrl'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  // character id에 해당하는 캐릭터에 관한 정보를 가져온다
  Future<Character> fetchCharacterInfo() async {
    print('Fetch fetchCharacterInfo data...');
    var url = Uri.parse(
        urlApi + '/character?characterId=2');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> body = json.decode(response.body);
      // print('body => $body');
      if (body['character'] == null) {
        print('error because character\'s info is empty');
      }

      return Character.fromJson(body['character']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  // 해당 user의 캐릭터 콜렉션 중 검색 결과에 해당하는 캐릭터를 반환할 때 사용한다
  Future<List<Character>> fetchSearchResult() async {
    print('Fetch fetchSearchResult data...');
    var url = Uri.parse(urlApi + '/character/search?search=turtle&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      // print('body => $body');
      if (body['characters'] == null) {
        print('error because user\'s fetchSearchResult is empty');
      }
      List<dynamic> list = body['resultCharacter'];
      // return list.map<Character>((characater) => Character.fromJson(characater)).toList();
      List<Character> result = [];
      list.map((innerList) => innerList.map((character) => result.add(Character.fromJson(character)))).toList();
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get users character');
    }
  }
















//   Future createCategory(int? userId, {String? categoryName, String? color}) async {
//     var url = Uri.parse(urlApi + '/character/user/collection?userId=1&characterId=4');
//     var paramObject = {};
//     paramObject.addAll({"userId": userId});
//     if(categoryName != null) paramObject.addAll({"categoryName": categoryName});
//     if(color != null) paramObject.addAll({"color": color});
//     var response = await http.post(url,
//         body: json.encode(paramObject),
//         headers: <String, String>{'Content-type': 'application/json'});
//     if (response.body == null) {
//       print('error with createCategory response');
//     }
//     if (response.body.isNotEmpty) {
//       return true;
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//       return false;
//     }
//   }

}