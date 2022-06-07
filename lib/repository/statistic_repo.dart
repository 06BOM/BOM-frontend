import 'dart:convert';
import 'package:bom_front/address/test_address.dart';
import 'package:bom_front/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

class StatisticRepository {
  static const urlApi = 'http://$conntectIp';
  /*한주의 별개수 가져오는 코드 */
  Future<int> getWeekStar() async {
    print("this is for get week star data");
    final http.Response response = await http
        .get(Uri.parse(urlApi + '/plan/week/star?date=${getToday()}&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['stars'] == null) {
        print('Error! because star is empty');
      }
      return body['stars'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load star data");
    }
  }

  /*한달의 별개수 가져오는 코드 */
  Future<int> getMonthstar() async {
    print("this is for get month star data");
    final http.Response response = await http.get(
        Uri.parse(urlApi + '/plan/month/star?date=${getToday()}&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['stars'] == null) {
        print('Error! because plan is empty');
      }
      return body['stars'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load star data");
    }
  }

/*한주의 시간 가져오는 코드 */
  Future<int> getWeekTime() async {
    print("this is for get week time data");
    final http.Response response = await http.get(
        Uri.parse(urlApi + '/plan/week/average?date=${getToday()}&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'].floor();
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }

/*한달의간시간 가져오는 코드 */
  Future<int> getMonthTime() async {
    print("tthis is for get month time data");
    final http.Response response = await http.get(
        Uri.parse(urlApi + '/plan/month/average?date=${getToday()}&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['averageTime'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['averageTime'].floor();
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }

  Future<List<int>> getWeekTimeChart() async {
    print("this is for get week time ");
    final http.Response response = await http.get(
        Uri.parse(urlApi + '/plan/week/total?date=${getToday()}&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['timeSum'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['timeSum'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }

  Future<List<int>> getMonthTimeChart() async {
    print("this is for get month time ");
    final http.Response response = await http.get(
        Uri.parse(urlApi + '/plan/month/total?date=${getToday()}&userId=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['timeSum'] == null) {
        print('Error! because averageTime is empty');
      }
      return body['timeSum'];
    } else {
      print("ERROR by this status : ${response.statusCode}");
      throw Exception("Failed to load time data");
    }
  }
}
/*
미구현 -> 날짜별 get 해와서 해당 차트안에 넣는것
 */

final apiProvider =
    Provider<StatisticRepository>((ref) => StatisticRepository());
