import 'dart:convert';
import 'package:dashboard_food_delivery/pages/users/users.dart';
import 'package:dashboard_food_delivery/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Future<bool> createUser(
  String name,
  String phone,
  String note,
  bool active,
  String password,
  BuildContext context,
) async {
  var url = Uri.parse(AppConstants.apiPath +
      "users/insert_user.php?token=" +
      AppConstants.token);

  Map data = {
    'name': name,
    'phone': phone,
    'password': password,
    'active': active ? '1' : '0',
    'note': note,
  };

  http.Response response = await http.post(url, body: data);

  if (json.decode(response.body)['code'] == '200') {
    Toast.show("تم إضافة المستخدم", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundRadius: 12);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Users()));
    print('done');
    return true;
  } else {
    print('error');
    return false;
  }
}

Future<List> getData(int count,String textSearch) async {
  var url = Uri.parse(AppConstants.apiPath +
      "users/read_user.php?textSearch=$textSearch&start=$count&end=10&token=" +
      AppConstants.token);

  http.Response response = await http.post(url);
  if (json.decode(response.body)['code'] == '200') {
    List dataList = jsonDecode(response.body)['message'];
    return dataList;
  }
  else {
   print('error in users data file');
   List dataList = [];
   return dataList;
  }
}
