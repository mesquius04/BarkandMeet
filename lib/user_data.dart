import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserData {
  static final Map<String, Map<String, dynamic>> _users = {};
  static final UserData _singleton = UserData._internal();

  factory UserData() {
    return _singleton;
  }

  UserData._internal();

  File? profilePhoto;
  String name = '';
  String surname = '';
  String email = '';
  String location = '';
  String additionalInfo = '';
  static void addUser(String username, String email, String password) {
    _users[username] = {
      'email': email,
      'password': password,
      'firstLogin': true,
      // otros datos del perfil si es necesario
    };
  }

  static bool validateUser(String username, String password) {
    if (_users.containsKey(username) &&
        _users[username]!['password'] == password) {
      return true;
    }
    return false;
  }

  static bool isFirstLogin(String username) {
    if (_users.containsKey(username)) {
      return _users[username]!['firstLogin'] as bool;
    }
    return false;
  }

  static void setFirstLogin(String username, bool value) {
    if (_users.containsKey(username)) {
      _users[username]!['firstLogin'] = value;
    }
  }
}
