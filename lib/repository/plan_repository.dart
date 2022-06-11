import 'dart:convert';
import 'package:bom_front/utils.dart';
import '../address/local_address.dart';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  static const urlApi = 'http://$localAddress';
      // 'http://ec2-3-37-166-70.ap-northeast-2.compute.amazonaws.com';
  final DateTime day;

  TodoRepository(this.day);

  Future<List<Todo>> loadTodos() async {
    print('Fetch plan data...');
    // var url = Uri.parse(urlApi + '/plan/all?date=1999-01-01&userId=1');
    var url = Uri.parse(
        urlApi + '/plan/all?date=${getBasicDateFormat(day)}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response
          .body); // var body = jsonDecode(response.body) as List<dynamic>;
      if (body['result'] == null) {
        // opcode의 청체 파악 후 적용하기
        print('error because plan is empty');
      }
      List<dynamic> list = body['result'];
      return list.map<Todo>((plan) => Todo.fromJson(plan)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future createTodo(Todo todos, String userSlectedDate) async {
    print('user => $day');
    var url = Uri.parse(urlApi + '/plan');
    var dateResult = userSlectedDate != '' ? userSlectedDate.split('/') : null;
    int? year;
    int? month;
    int? theday;
    if (dateResult != null) {
      year = int.parse(dateResult[0]);
      month = int.parse(dateResult[1]);
      theday = int.parse(dateResult[2]);
    }
    print('year = $year / month = $month');
    print('userId = ${todos.userId}');

    var response = await http.post(url,
        body: json.encode({
          "planName": todos.planName,
          "categoryId": todos.categoryId,
          "userId": todos.userId, // 추후 변경 하기
          "date": getBasicDateFormat(day),
          "repetitionType": todos.repetitionType,
          "year": year,
          "moth": month,
          "day": theday,
          "days": [0, 0, 0, 0, 0, 0, 0],
        }),
        headers: <String, String>{'Content-type': 'application/json'});
    print('createTodo => ${response.body}');
    if (response.body == null) {
      print('error with createTodo response');
    }
    if (response.body.isNotEmpty) {
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future editTodo(int? planId,
      {bool? check,
      String? planName,
      int? repetitionType,
      int? categoryId,
      String? userSelectedDate,
      List<int>? userSelectedWeek}) async {
    var url = Uri.parse(urlApi + '/plan/' + '$planId');
    var paramObject = {};
    if (check != null) paramObject.addAll({"check": check});
    if (planName != null) paramObject.addAll({"planName": planName});
    if (repetitionType != null) {
      paramObject.addAll({"repetitionType": repetitionType});
    }
    if (categoryId != null) paramObject.addAll({"categoryId": categoryId});
    if (userSelectedDate != null) {
      var dateResult = userSelectedDate.split('/');
      paramObject.addAll({
        "year": int.parse(dateResult[0]),
        "month": int.parse(dateResult[1]),
        "day": int.parse(dateResult[2])
      });
    }
    if (userSelectedWeek != null) {
      paramObject.addAll({"userSelectedWeek": userSelectedWeek});
    }

    print('paramObject => $paramObject');
    var response = await http.patch(url,
        body: json.encode(paramObject),
        headers: <String, String>{'Content-type': 'application/json'});
    print(response.body);
    // print(response.headers);
    // print(response.statusCode);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 404) {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    } else {
      return true;
    }
  }

  Future deleteTodo(id) async {
    var url = Uri.parse(urlApi + '/plan/' + '$id');
    var response = await http.delete(url);
    print('delete success!');
    if (response.statusCode >= 404) {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    } else {
      return true;
    }
  }

  Future<int> loadStars() async {
    // print('Fetch star data...');
    var url = Uri.parse(
        urlApi + '/plan/star?date=${getBasicDateFormat(day)}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['star'] == null) {
        print('Error! because plan is empty');
      }
      return body['star'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future<List<MonthlyStars>> loadMonthlyStars() async {
    print('Fetch ${getBasicDateFormat(day)}월 star data...');
    var url = Uri.parse(urlApi +
        '/plan/month/all/star?date=${getBasicDateFormat(day)}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['allMonthlyStars'] == null) {
        print('Error! because plan is empty');
      }
      print('body => $body');
      List<dynamic> list = body['allMonthlyStars'];
      return list
          .map<MonthlyStars>((plan) => MonthlyStars.fromJson(plan))
          .toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }

  Future<int> loadDailyTotalTimes() async {
    print('Fetch daily total times data...');
    print('time repo -> $day');
    var url = Uri.parse(
        urlApi + '/plan/total?date=${getBasicDateFormat(day)}&userId=1');
    var response = await http.get(url);
    if (response.body == null) {
      print('error with get');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['totalTime'] == null) {
        print('Error! because plan is empty');
      }
      return body['totalTime'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Can\'t get plans');
    }
  }
}
