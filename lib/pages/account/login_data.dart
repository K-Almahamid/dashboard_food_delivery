import 'dart:convert';
import 'package:dashboard_food_delivery/pages/home/home.dart';
import 'package:dashboard_food_delivery/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<bool> loginUsers(
    String phone, String password, BuildContext context) async {
  var url = Uri.parse(
      AppConstants.apiPath +
      "users/login.php?phone="+
      phone+
      "&password="+
      password+
      "&token=" +
      AppConstants.token,
  );

  http.Response response = await http.get(url);
  if (json.decode(response.body)['code'] == '200') {
    Map data = json.decode(response.body)['message'];
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(AppConstants.userId, data['id']);
    sharedPref.setString(AppConstants.userName, data['name']);
    sharedPref.setString(AppConstants.userPhone, data['phone']);
    // sharedPref.setString(AppConstants.userImage, data['image']);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
print('done');
    return true;
  } else {
    print('error');
    return false;
  }
}
