import 'package:dashboard_food_delivery/pages/component/progress.dart';
import 'package:dashboard_food_delivery/pages/users/users_data.dart';
import 'package:dashboard_food_delivery/provider/loading.dart';
import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:dashboard_food_delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool checkActive = false;
  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void addUser(BuildContext context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("لا يوجد اتصال بلانترنت", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool isValid = _formKey.currentState!.validate();
    load.addLoading();

    if (phoneController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        noteController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        isValid) {
      isLoading = true;
      load.addLoading();
      //return true or false
      bool result = await createUser(
        nameController.text,
        phoneController.text,
        noteController.text,
        checkActive,
        passwordController.text,
        context,
      );

      isLoading = result;
      load.addLoading();
    } else {
      Toast.show("الرجاء ادخال البيانات", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        shadowColor: AppColors.mainColor,
        title: const Text(
          'إضافة مستخدم جديد',
          style: TextStyle(color: AppColors.blackColor),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<LoadingControl>(
                builder: (context, load, child) {
                  return Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: 'اسم المستخدم',
                                border: InputBorder.none,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'الرجاء ادخال اسم المستخدم';
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: 'رقم الهاتف',
                                border: InputBorder.none,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'الرجاء ادخال رقم الهاتف';
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: noteController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: 'الملاحظات',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Checkbox(
                              value: checkActive,
                              onChanged: (value) {
                                setState(() {
                                  checkActive = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                hintText: 'كلمة المرور',
                                border: InputBorder.none,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'الرجاء ادخال كلمة المرور';
                                }
                              },
                            ),
                          ),
                          isLoading
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
                                      'انشاء مستخدم جديد',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    addUser(context, load);
                                  },
                                ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
