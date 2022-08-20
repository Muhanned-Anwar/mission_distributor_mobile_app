import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/app_getX_controller.dart';
import 'package:mission_distributor/core/res/assets.dart';
import 'package:mission_distributor/views/app/mission/main_screen.dart';
import 'package:mission_distributor/views/app/mission/missions_screen.dart';
import 'package:mission_distributor/views/app/profile_screen.dart';
import '../../models/app/bottom_navigation_bar_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      widget: const MainScreen(),
      title: '',
      icon: const Icon(Icons.home_filled),
    ),
    BottomNavigationBarScreen(
      widget: const MissionsScreen(),
      title: '',
      icon: Image.asset(
        Assets.logoBottomNavBarIcon,
        color: Colors.grey.shade600,
        filterQuality: FilterQuality.high,
      ),
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

    return Obx(() => Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: OrientationBuilder(
            builder: (context, orientation) =>
                _bnScreens[_appGetXController.selectedBottomBarScreen].widget,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey.shade300,
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,

                currentIndex: _appGetXController.selectedBottomBarScreen,
                onTap: (value) {
                  _appGetXController.changeSelectedBottomBarScreen(
                      selectedIndex: value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: _bnScreens[0].icon,
                    label: AppLocalizations.of(context)!.home,
                  ),
                  BottomNavigationBarItem(
                    icon: _bnScreens[1].icon,
                    activeIcon: Image.asset(
                      Assets.logoBottomNavBarActiveIcon,
                    ),
                    label: AppLocalizations.of(context)!.mission,
                  ),
                  BottomNavigationBarItem(
                    icon: _bnScreens[2].icon,
                    label: AppLocalizations.of(context)!.profile,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
