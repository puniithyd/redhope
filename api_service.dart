import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use your Render backend URL
  static const String baseUrl = 'https://redhope-backend-3.onrender.com/api';

  Future<Map<String, dynamic>> registerDonor(Map<String, dynamic> donorData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/donors'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(donorData),
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to register donor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<dynamic>> getDonors({String? bloodGroup, String? city}) async {
    try {
      String url = '$baseUrl/donors';
      List<String> params = [];
      
      if (bloodGroup != null && bloodGroup.isNotEmpty) params.add('bloodGroup=$bloodGroup');
      if (city != null && city.isNotEmpty) params.add('city=$city');
      
      if (params.isNotEmpty) url += '?' + params.join('&');
      
      print('Request URL: $url');
      
      final response = await http.get(Uri.parse(url));
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['donors'];
      } else {
        throw Exception('Failed to load donors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
