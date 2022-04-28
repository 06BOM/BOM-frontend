import 'dart:convert';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class StatisticRepository {
  static const urlApi =
      'http://ec2-3-39-177-232.ap-northeast-2.compute.amazonaws.com';

  Future<Todo> getChartData() async {
    print("this is for get time per date");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/total?date=2022-04-26&userId=1'));

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }
}
/*
미구현 -> 날짜별 get 해와서 해당 차트안에 넣는것
 */
