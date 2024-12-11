import 'dart:developer';

import 'package:biteblitz/src/utils/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  static const String authToken = 'authToken';
  static const String restaurantName = 'restaurant_Name';
  static const String restaurantEmail = 'restaurant_Email';
  static const String onboarding_stage = 'onboarding_stage';
}

class SharedPrefHelper {
  /// Save a token securely
  static Future<void> saveToken(String token) async {
    if (token.isEmpty) {
      throw Exception("Token cannot be empty");
    }
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      await _prefs.setString('auth_token', token);
      log("\nadded auth_token\n", name: "SharedPrefHelper");
    } catch (e) {
      print("Error saving token: $e");
      throw Exception("Failed to save token");
    }
  }

  /// Retrieve the token
  static Future<String?> getToken() async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      return _prefs.getString('auth_token');
    } catch (e) {
      print("Error retrieving token: $e");
      return null; // Return null if an error occurs
    }
  }

  /// Remove the token
  static Future<void> removeToken(BuildContext context) async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      await _prefs.remove('auth_token');
      removeValue(SharedPrefKeys.onboarding_stage);
      context.go(routeNames.login);
      log("\n removed auth_token\n", name: "SharedPrefHelper");
    } catch (e) {
      print("Error removing token: $e");
      throw Exception("Failed to remove token");
    }
  }

  /// Check if a token exists
  static Future<bool> hasToken() async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      final String? token = _prefs.getString('auth_token');
      return token != null && token.isNotEmpty;
    } catch (e) {
      print("Error checking token existence: $e");
      return false; // Default to no token if an error occurs
    }
  }

  /// Save generic key-value pair
  static Future<void> saveValue<T>(String key, T value) async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      } else if (value is double) {
        await _prefs.setDouble(key, value);
      } else {
        throw Exception("Unsupported type for SharedPreferences");
      }
      log("\nadded key:$key   ---  value: $value\n", name: "SharedPrefHelper");
    } catch (e) {
      print("Error saving value: $e");
      throw Exception("Failed to save value for key: $key");
    }
  }

  /// Retrieve generic key-value pair
  static Future<T?> getValue<T>(String key) async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      // log("Retrieving key:$key as type:${T.toString()}", name: "SharedPrefHelper");

      if (T == String) {
        return _prefs.getString(key) as T?;
      } else if (T == int) {
        return _prefs.getInt(key) as T?;
      } else if (T == bool) {
        return _prefs.getBool(key) as T?;
      } else if (T == double) {
        return _prefs.getDouble(key) as T?;
      } else {
        throw Exception("Unsupported type for SharedPreferences");
      }
    } catch (e) {
      print("Error retrieving value: $e");
      return null; // Return null if an error occurs
    }
  }

  /// Remove a key-value pair
  static Future<void> removeValue(String key) async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      await _prefs.remove(key);
    } catch (e) {
      print("Error removing value: $e");
      throw Exception("Failed to remove value for key: $key");
    }
  }
}
