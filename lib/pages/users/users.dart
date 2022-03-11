import 'package:dashboard_food_delivery/pages/component/progress.dart';
import 'package:dashboard_food_delivery/pages/users/add_user.dart';
import 'package:dashboard_food_delivery/pages/users/edit_user.dart';
import 'package:dashboard_food_delivery/pages/users/users_data.dart';
import 'package:dashboard_food_delivery/provider/loading.dart';
import 'package:dashboard_food_delivery/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<SingleUser> usersList = <SingleUser>[];
class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late ScrollController scroll;
  bool loadingList = false;

  late GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;

  void getUserData(int count, String textSearch) async {
    loadingList = true;
    setState(() {});
    List data = await getData(count, textSearch);
    for (int i = 0; i < data.length; i++) {
      usersList.add(
        SingleUser(
          userIndex: i,
          id: data[i]['id'],
          name: data[i]['name'],
          phone: data[i]['phone'],
          active: data[i]['active'],
          note: data[i]['note'],
          lastDate: data[i]['lastdate'],
        ),
      );
    }
    loadingList = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init variable
    scroll = ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    //make list empty before add
    usersList.clear();
    getUserData(0, '');

    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        i += 10;
        getUserData(i, '');
        print('scroll');
      }
    });
  }

  Icon searchIcon = const Icon(
    Icons.search,
    color: AppColors.blackColor,
  );
  Widget appBarTitle = const Text(
    'إدارة المستخدمين',
    style: TextStyle(color: AppColors.blackColor),
  );

  void searchClick() {
    if (searchIcon.icon == Icons.search) {
      searchIcon = const Icon(Icons.close, color: AppColors.blackColor);
      appBarTitle = TextField(
        style: const TextStyle(color: AppColors.blackColor),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.blackColor),
          hintText: 'ابحث....',
          hintStyle: TextStyle(color: AppColors.blackColor),
          border: InputBorder.none,
          focusColor: AppColors.mainColor,
        ),
        onChanged: (text) {
          print(text);
          i = 0;
          usersList.clear();
          getUserData(0, text);
          setState(() {});
        },
      );
    } else {
      searchIcon = const Icon(Icons.search, color: AppColors.blackColor);
      appBarTitle = const Text(
        'البحث باسم المستخدم',
        style: TextStyle(color: AppColors.blackColor),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        shadowColor: AppColors.mainColor,
        title: appBarTitle,
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
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: searchIcon,
              onTap: () {
                searchClick();
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        color: AppColors.mainColor,
        onRefresh: () async {
          i += 10;
          usersList.clear();
          getUserData(0, '');
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  controller: scroll,
                  itemCount: usersList.length,
                  itemBuilder: (BuildContext context, index) {
                    final item = usersList[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.startToEnd,
                      child: SingleUser(
                        userIndex: index,
                        id: item.id,
                        name: item.name,
                        phone: item.phone,
                        active: item.active,
                        note: item.note,
                        lastDate: item.lastDate,
                      ),
                      onDismissed: (direction) {
                        usersList.remove(item);
                        Provider.of<LoadingControl>(context,listen: false).addLoading();
                      },
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width / 2,
                child: loadingList ? circularProgress() : const Text(''),
              ),
            ],
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
                  'إضافة مستخدم جديد',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUser(),
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

class SingleUser extends StatelessWidget {
  final int userIndex;
  final String id;
  final String name;
  final String phone;
  final String active;
  final String note;
  final String lastDate;

  const SingleUser({
    Key? key,
    required this.userIndex,
    required this.id,
    required this.name,
    required this.phone,
    required this.active,
    required this.note,
    required this.lastDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoadingControl>(context,listen: false);
    return Card(
      child: Column(
        children: [
          Container(
            child: ListTile(
              title: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone,
                    style: const TextStyle(color: AppColors.greyColor),
                  ),
                  Text(
                    lastDate,
                    style: const TextStyle(color: AppColors.greyColor),
                  ),
                ],
              ),
              // leading: Container(
              //   width: 60,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: AssetImage(note),
              //     ),
              //   ),
              // ),
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
                            builder: (context) => const EditUser(),
                          ),
                        );
                      },
                    ),
                    const Expanded(child: Text('')),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        usersList.removeAt(userIndex);
                        provider.addLoading();
                      },
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

