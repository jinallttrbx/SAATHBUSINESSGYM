
import 'package:businessgym/Screen/authentication/signin.dart';

import 'package:businessgym/conts/key_conts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorageService {
  Future<bool> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(KeyConst.isAlreadyLogin, value);
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KeyConst.loginToken, value);
  }
  Future<bool> setFirstname(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KeyConst.firstname, value);
  }

  Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KeyConst.userId, value);
  }

  Future<bool> setPinCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KeyConst.pinCode, value);
  }

  Future<bool?> getLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(KeyConst.isAlreadyLogin) ?? false;
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConst.loginToken) ?? "";
  }
  Future<String?> getfirstname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConst.firstname) ?? "";
  }

  Future<String?> getPinCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConst.pinCode) ?? "";
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConst.userId) ?? "";
  }

  Future getApiHeaderWithToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KeyConst.loginToken) ?? "";
    return {"Authorization": "Bearer $token"};
  }


}
