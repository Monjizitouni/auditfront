import 'dart:convert';

import 'package:audit/screens/models/classe.dart';
import 'package:audit/screens/util/constantes.dart';
import 'package:http/http.dart' as http;

class ClasseApi {
  Future<List<Classe>> getClassesByNiveau(int level) async {
    final response = await http.get(
      Uri.parse('$baseURL/classes/nv/${level.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Classe.fromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }
}