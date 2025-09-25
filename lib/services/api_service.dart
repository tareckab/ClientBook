import 'dart:convert';
import 'package:http/http.dart' as http;

//responsável por realizar operações HTTP (GET, POST, PUT, DELETE) 

class ApiService {
  static const String baseUrl = 'https://68b0e9ef3b8db1ae9c052717.mockapi.io';
  static const String usersEndpoint = '/users';

  static Uri _u(String path, [Map<String, String>? q]) =>
      Uri.parse('$baseUrl$path').replace(queryParameters: q);

  static Future<List<Map<String, dynamic>>> listUsersRaw() async {
    final res = await http.get(_u(usersEndpoint));
    if (res.statusCode == 200) { // se o request for = 200, retornara um response com a api em json
      final data = jsonDecode(res.body);
      if (data is List) return data.cast<Map<String, dynamic>>();
    }
    throw Exception('Falha ao listar usuários: ${res.statusCode}');
  }

  static Future<Map<String, dynamic>> createUser(
      Map<String, dynamic> body) async {
    final res = await http.post(
      _u(usersEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Falha ao criar: ${res.statusCode}');
  }

  static Future<Map<String, dynamic>> updateUser(
      String id, Map<String, dynamic> body) async {
    final res = await http.put(
      _u('$usersEndpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Falha ao atualizar: ${res.statusCode}');
  }

  static Future<void> deleteUser(String id) async {
    final res = await http.delete(_u('$usersEndpoint/$id'));
    if (res.statusCode != 200) {
      throw Exception('Falha ao remover: ${res.statusCode}');
    }
  }
}
