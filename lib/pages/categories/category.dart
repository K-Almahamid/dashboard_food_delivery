import 'package:dashboard_food_delivery/pages/categories/add_category.dart';
import 'package:dashboard_food_delivery/pages/categories/edit_category.dart';
import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var products = [
    {
      'pro_id': '1',
      'pro_name': 'سمك',
      'pro_image': 'assets/images/product/pro1.jpg',
      'pro_qty': '20',
      'pro_price': '10',
    },
    {
      'pro_id': '2',
      'pro_name': 'مشاوي',
      'pro_image': 'assets/images/product/pro2.jpg',
      'pro_qty': '20',
      'pro_price': '10',
    },
    {
      'pro_id': '3',
      'pro_name': 'كبة',
      'pro_image': 'assets/images/product/pro3.jpg',
      'pro_qty': '20',
      'pro_price': '10',
    },
    {
      'pro_id': '3',
      'pro_name': 'كبة',
      'pro_image': 'assets/images/product/pro3.jpg',
      'pro_qty': '20',
      'pro_price': '10',
    },
    {
      'pro_id': '3',
      'pro_name': 'كبة',
      'pro_image': 'assets/images/product/pro3.jpg',
      'pro_qty': '20',
      'pro_price': '10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        shadowColor: AppColors.mainColor,
        title: const Text(
          'إدارة التصنيفات',
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
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, index) {
              return SingleProduct(
                pro_id: products[index]['pro_id']!,
                pro_name: products[index]['pro_name']!,
                pro_price: products[index]['pro_price']!,
                pro_qty: products[index]['pro_qty']!,
                pro_image: products[index]['pro_image']!,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                child: const Text(
                  'إضافة تصنيف جديد',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCategory(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleProduct extends StatelessWidget {
  final String pro_id;
  final String pro_name;
  final String pro_price;
  final String pro_qty;
  final String pro_image;

  const SingleProduct({
    Key? key,
    required this.pro_id,
    required this.pro_name,
    required this.pro_price,
    required this.pro_qty,
    required this.pro_image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            child: ListTile(
              title: Text(
                pro_name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                pro_price,
                style: const TextStyle(color: AppColors.greyColor),
              ),
              leading: Container(
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(pro_image),
                  ),
                ),
              ),
              trailing: Container(
                width: 80,
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.blueColor,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCategory(),
                          ),
                        );
                      },
                    ),
                    Expanded(child: Text('')),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
