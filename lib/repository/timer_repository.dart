import 'dart:convert';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TimerRepository {
  static const urlApi =
      'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';
  /*
  시간 30분 될때마다 별 증가 API 탕탕탕!

   */
  Future postStarData() async {
    print("shooting stars");

    final http.Response response =
        await http.post(Uri.parse(urlApi + '/plan/star'));
    print(response.body);
    if (response.body == null) {
      print('error with get stars');
    }
    if (response.body.isNotEmpty) {
      return true;
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }

  /*
  타이머 실행시 해당 타이머 데이터를 받아올 때 사용된다.
   */
  Future<int> getTimeData() async {
    print("Fetch time data...");
    final http.Response response =
        await http.get(Uri.parse(urlApi + '/plan/' + 'planId' + 'time'));
    if (response.body == null) {
      print('error with get timeData');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      if (body['totalTime'] == null) {
        print("Error because totalTime is empty");
      }
      return body['totalTime'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load timerdata");
    }
  }

  // Future<int> getDailyTimeData() async {
  //   print("Fetch daily time data...");
  //   final http.Response response = await http
  //       .get(Uri.parse(urlApi + '/plan/total?date=${date}&userId=${userId}'));
  //   if (response.body == null) {
  //     print('error with get dailytimeData');
  //   }
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> body = jsonDecode(response.body);
  //     if (body['totalTime'] == null) {
  //       print("Error because totalTime is empty");
  //     }
  //     return body['totalTime'];
  //   } else {
  //     print("ERROR by this status : ${response.statusCode}");
  //     throw Exception("Failed to load timerdata");
  //   }
  // }
}
