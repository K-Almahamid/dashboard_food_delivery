import 'package:dashboard_food_delivery/pages/account/login_data.dart';
import 'package:dashboard_food_delivery/pages/component/progress.dart';
import 'package:dashboard_food_delivery/pages/home/home.dart';
import 'package:dashboard_food_delivery/provider/loading.dart';
import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:dashboard_food_delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context, load) async {
    if (!await checkConnection()) {
      Toast.show("لا يوجد اتصال بلانترنت", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading = true;
      load.addLoading();

      //return true or false
      bool result = await loginUsers(
          phoneController.text, passwordController.text, context);

      isLoading = result;
      load.addLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 35),
                        child: const Text(
                          'سجل الدخول الى حسابك ',
                          style: TextStyle(
                              color: AppColors.mainColor, fontSize: 20.0),
                        ),
                      ),
                      //form
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'رقم الهاتف ',
                            border: InputBorder.none,
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال رقم الهاتف ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'كلمة المرور',
                            border: InputBorder.none,
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'الرجاء ادخال كلمة المرور';
                            }
                            return null;
                          },
                        ),
                      ),
                      Consumer<LoadingControl>(
                        builder: (context, load, child) {
                          return isLoading
                              ? circularProgress()
                              : MaterialButton(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        bottom: 10, top: 30),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    login(context, load);
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
