import 'dart:convert';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TimerRepository {
  static const urlApi =
      'http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com';

  Future<Todo> getTimerData() async {
    print("this is for get category color, plan name, time");
    final http.Response response =
        await http.get(Uri.parse(urlApi + '/1/data'));

    if (response.statusCode == 200) {
      print(Todo.fromJson(jsonDecode(response.body)));
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }

  Future<Todo> postStarData(int num) async {
    print("this is count seconds and send how many stars user get");

    final http.Response response = await http.post(
        Uri.parse(urlApi + '/plan/star'),
        body: <String, int>{"star": num},
        headers: <String, String>{'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }

  Future<Todo> getStarData() async {
    // 문제는 todo에 별이 없다는거!
    print("this is for get star num");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/star?date=2022-04-27&userId=1'));

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }
}
