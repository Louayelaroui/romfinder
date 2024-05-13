import 'package:flutter/foundation.dart';

import '../helper/http_client.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class AuthRepo {
  static final endPoints = {
    "sigIn": "/api/auth/signin",
    "signUp": "/api/auth/signup",
    "logout": "/api/auth/logout",
    "delete": "/api/auth/delete",
  };
  static Future<User> signUp({
    required String name,
    required String email,
    required String password,
    required String cin,
    required String telephone,
    required String specialRequirements,
    required String role,
  }) async {
    try {
      var response = await HttpClient.post(endPoint: endPoints["signUp"], body: {
        "name": name,
        "email": email,
        "password": password,
        "cin": cin,
        "telephone": telephone,
        "special_requirements": specialRequirements,
        "role": role,
      });

      if (kDebugMode) {
        print('API Response: $response');
      }
      User user = User.fromJson(response);

      return user;
    } catch (e) {
      if (kDebugMode) {
        print('Error in signUp: $e');
      }

      // Handle the error accordingly, for now, throw an exception
      throw Exception('Error in signUp: $e');
    }
  }
  static Future<void> signIn({required String username, required String password}) async {
    var value = await HttpClient.post(endPoint: endPoints["sigIn"], body: {"username": username, "password": password});
    var pref = await SharedPreferences.getInstance();

    // Store the JWT token
    await pref.setString("token", value["access_token"]);

    // Assuming clubType is returned in the login response
    if (value.containsKey("clubType")) {
      await pref.setString("clubType", value["clubType"]);
    }
  }

  static Future<void> logOut() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove("token");
    await pref.remove("clubType");
  }

  static Future<void> deleteUser({required String username}) async {
    try {
      var response = await HttpClient.delete(endPoints["delete"]!, body: {"username": username});


      if (response.statusCode == 200) {
        print('User successfully deleted.');
      } else {
        print('Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}

