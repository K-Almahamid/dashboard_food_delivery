import 'package:dashboard_food_delivery/pages/account/login.dart';
import 'package:dashboard_food_delivery/pages/home/home.dart';
import 'package:dashboard_food_delivery/provider/loading.dart';
import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:dashboard_food_delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // for null values
  sharedPref = await SharedPreferences.getInstance();

  if (sharedPref.getString(AppConstants.userId) != null) {
    userIdValue = sharedPref.getString(AppConstants.userId)!;
  } else {
    userIdValue = '';
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingControl>(
            create: (context) => LoadingControl())
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'GE_ar'
        ),
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: userIdValue == '' ? const Login() : const Home(),
      title: const Text(
        'مرحبا بك في تطبيق إدارة مطعمنا',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      // image: Image.network(
      //     'https://i.pinimg.com/236x/34/57/30/345730a335becf43c2a3272e79074f9c.jpg'),
      backgroundColor: AppColors.mainColor,
      loaderColor: Colors.white,
      photoSize: 100,
    );
  }
}
