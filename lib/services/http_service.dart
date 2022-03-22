import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_api_test/const/api_paths.dart';

class HttpService {
  HttpService._();

  static Future<dynamic> addUser(String name, String age) async {
    final url = "$baseUrl/$addUrl/${int.parse(age)}/$name";
    log(url);
    final response =
        await http.put(Uri.parse("$baseUrl/$addUrl/${int.parse(age)}/$name"));
    return jsonDecode(response.body);
  }

  static Future<dynamic> userList() async {
    final response = await http.get(Uri.parse("$baseUrl/$usersUrl"));
    return jsonDecode(response.body);
  }

  static Future<dynamic> deleteUser(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$deleteUrl/$id"));
    return jsonDecode(response.body);
  }
}
