import 'dart:convert';
import 'package:bom_front/model/category.dart';
import 'package:http/http.dart' as http;
import '../address/local_address.dart';
import '../model/user.dart';

class UserRepository {
  static const urlApi = 'http://$localAddress:3000';
      // 'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';

  Future<User> loadUser() async {
    print('Fetch User\'s data...');
    var url = Uri.parse(urlApi + '/user/1');
    var response = await http.get(url);
    print('${response.body} in loadUser');
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('body => $body');
      if (body['getUserResult'] == null) {
        print('error because plan is empty');
      }

      return User.fromJson(body['getUserResult']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future<List<Category>> loadUserCategory() async {
    print('Fetch User\'s Category data...');
    var url = Uri.parse(urlApi + '/category/user?userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('category.len => ${body['category'].length}');
      if (body['category'] == null) {
        print('error because plan is empty');
      }
      List<dynamic> list = body['category'];
      return list
          .map<Category>((category) => Category.fromJson(category))
          .toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future createCategory(int? userId,
      {String? categoryName, String? color}) async {
    var url = Uri.parse(urlApi + '/category');
    var paramObject = {};
    paramObject.addAll({"userId": userId});
    if (categoryName != null) {
      paramObject.addAll({"categoryName": categoryName});
    }
    if (color != null) paramObject.addAll({"color": color});
    var response = await http.post(url,
        body: json.encode(paramObject),
        headers: <String, String>{'Content-type': 'application/json'});
    if (response.body == null) {
      print('error with createCategory response');
    }
    if (response.body.isNotEmpty) {
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }
}
