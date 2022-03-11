import 'package:dashboard_food_delivery/pages/categories/category.dart';
import 'package:dashboard_food_delivery/pages/settings/drawer.dart';
import 'package:dashboard_food_delivery/pages/users/users.dart';
import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _keyDrawer = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: _keyDrawer,
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        elevation: 0.0,
        title:const Text('إدارة المطعم',style: TextStyle(color: AppColors.blackColor),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: const Icon(
                Icons.sort,
                color: AppColors.mainColor,
                size: 40,
                textDirection: TextDirection.rtl,
              ),
              onTap: (){
                _keyDrawer.currentState!.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.greyColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: const [
                          Icon(Icons.people, size: 80, color: AppColors.mainColor),
                          Text(
                            'المستخدمين',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Users(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.greyColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: const [
                          Icon(Icons.menu_book, size: 80, color: AppColors.yellowColor),
                          Text(
                            'التصنيفات',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Category(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: const [
                        Icon(Icons.delivery_dining, size: 80, color: AppColors.mainColor),
                        Text(
                          'الطلبات',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: const [
                        Icon(Icons.restaurant, size: 80, color: AppColors.iconColor1),
                        Text(
                          'المأكولات',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: const [
                        Icon(Icons.notifications, size: 80, color: AppColors.mainColor),
                        Text(
                          'الاشعارات',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: const [
                        Icon(Icons.history, size: 80, color: AppColors.blueColor),
                        Text(
                          'الطلبات قيد التنفيذ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
