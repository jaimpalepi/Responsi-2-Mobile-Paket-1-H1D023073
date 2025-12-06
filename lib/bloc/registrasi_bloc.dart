import 'dart:convert';
import 'package:mart/helpers/api.dart';
import 'package:mart/helpers/api_url.dart';
import 'package:mart/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;
    print("=== REGISTRASI DEBUG ===");
    print("API URL: $apiUrl");

    var body = {"nama": nama, "email": email, "password": password};
    print("Body: $body");

    try {
      var response = await Api().post(apiUrl, body);
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      var jsonObj = json.decode(response.body);
      return Registrasi.fromJson(jsonObj);
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}