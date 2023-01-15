import 'dart:convert';

import 'package:audit/screens/models/student.dart';
import 'package:audit/screens/util/constantes.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentApi {
  Future<String> studentLogin(String email, String password) async {
    final response = await http.post(
    Uri.parse('$baseURL/client/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    print(response);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("NUM_CLIENT", responseBody["NUM_CLIENT"]);
      await prefs.setString("E_mail", responseBody["E_mail"]);
      return "login success";
}return "Login Failed!";
  }}