import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> loginUser(String email, String password) async {
    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseData['access_token']);
      await prefs.setString('user', jsonEncode(responseData['user']));
      print('Login successful');
    } else {
      print('Failed to login: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('https://www.lotusgoldmarkets.co/api/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user');
    }
  }
}
