import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/app_getX_controller.dart';
import 'package:mission_distributor/views/app/mission/missions_screen.dart';
import 'package:mission_distributor/views/app/profile_screen.dart';
import '../../models/app/bottom_navigation_bar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double width;
  late double height;

  final AppGetXController _appGetXController = Get.put(AppGetXController());

  final List<BottomNavigationBarScreen> _bnScreens =
  <BottomNavigationBarScreen>[
    BottomNavigationBarScreen(
      widget: const MissionsScreen(),
      title: '',
      icon: const Icon(Icons.check_circle_outline),
    ),
    BottomNavigationBarScreen(
      widget: const ProfileScreen(),
      title: '',
      icon: const Icon(Icons.person),
    ),
  ];


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Obx(
        () => Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: OrientationBuilder(builder: (context, orientation) => _bnScreens[_appGetXController.selectedBottomBarScreen].widget,),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey.shade300,
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: _appGetXController.selectedBottomBarScreen,
                onTap: (value) {
                  _appGetXController.changeSelectedBottomBarScreen(selectedIndex: value);
                },
                items: [
                  BottomNavigationBarItem(icon: _bnScreens[0].icon, label: ''),
                  BottomNavigationBarItem(icon: _bnScreens[1].icon, label: ''),
                ],
              ),
            ),
          ),
        )
    );
  }
}
