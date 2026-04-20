// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  Future<Map<String, dynamic>> registerDonor(Map<String, dynamic> donorData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/donors'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(donorData),
    );
    return json.decode(response.body);
  }

  Future<List<dynamic>> getDonors({String? bloodGroup, String? city}) async {
    String url = '$baseUrl/donors';
    if (bloodGroup != null || city != null) {
      url += '?';
      if (bloodGroup != null) url += 'bloodGroup=$bloodGroup&';
      if (city != null) url += 'city=$city';
    }
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
}