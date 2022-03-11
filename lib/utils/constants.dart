import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref; //get data from sharedPref
String userIdValue = "";

Future<bool> checkConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('there are connection');
      return true;
    } else {
      print('there are no connection');
      return false;
    }
  } on SocketException catch (e) {
    print(e);
    return false;
  }
}

class AppConstants {
  static const String token = "kkkkkkkkskskskdfnnfgf";
  static const String apiPath = "http://192.168.1.9/food_delivery/api/";
  static const String imagesPath = "http://192.168.1.9/food_delivery/images/";

  static const String userId = "id";
  static const String userName = "name";
  static const String userPhone = "phone";
  static const String userImage = "image";
}
