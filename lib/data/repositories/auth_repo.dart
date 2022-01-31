import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../models/models.dart';
import '../api_services/apis.dart';

class AuthRepository extends ChangeNotifier {
  final LoginAPI _loginAPI = LoginAPI();
  UserModel? _currentUser;
  bool _authenticated = false;
  bool get authenticated => _authenticated;

  set authenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }

  UserModel get currentUser => _currentUser!;

  Future<void> loginWithCredentials(
      {required String username, required String password}) async {
    Response response;
    try {
      response =
          await _loginAPI.loggedIn(username: username, password: password);
      if (response.statusCode == 200) {
        _currentUser = UserModel.fromJson(response.data['data']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userData", json.encode(_currentUser!.toJson()));

        // Change the value of authenticated then notify
        _authenticated = true;
        notifyListeners();
      } else {
        throw Exception(response.data['message']);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  bool isLoggedIn() => _currentUser != null;

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    prefs.remove("userData");
    _currentUser = null;

    // Change the value of authenticated then notify
    _authenticated = false;
    notifyListeners();
  }

  ///Singleton factory
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();
}
