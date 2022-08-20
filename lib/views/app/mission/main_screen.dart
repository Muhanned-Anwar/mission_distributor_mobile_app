import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/mission_getX_controller.dart';
import 'package:mission_distributor/core/res/assets.dart';
import 'package:mission_distributor/core/res/mission_distributor_colors.dart';
import 'package:mission_distributor/core/res/routes.dart';
import 'package:mission_distributor/core/utils/helpers.dart';
import 'package:mission_distributor/models/missions/mission.dart';
import 'package:mission_distributor/models/network_link.dart';
import 'package:mission_distributor/views/app/mission/mission_details_screen.dart';
import '../../../controllers/getX/app_getX_controller.dart';
import '../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../core/widgets/MyElevatedButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers{
  late double width;
  late double height;
  String done = '0';
  String todo = '0';

  final MissionGetXController _missionGetXController =
      Get.put(MissionGetXController());

  List<Mission> missions = [];

  bool _selectedDoneMissions = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool connection = false;

  @override
  void initState() {
    super.initState();
    testConnection();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      showSnackBar(context: context, message: 'Couldn\'t check connectivity status',error: true);
      return;
    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }


  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  testConnection() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      connection = true;
    } else {
      connection = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
          connection;
      },
    );
    return Scaffold(
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.home,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.account_balance_wallet_rounded,
            color: MissionDistributorColors.primaryColor,
            size: 26,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.walletScreen);
          },
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 16,
              child: Assets.profileImage != ''
                  ? Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            UserPreferenceController().userInformation.avatar !=
                                    ''
                                ? !(_connectionStatus.name != 'none' || connection)
                                    ? const Icon(Icons.person)
                                    : Image.network(UserPreferenceController()
                                            .userInformation
                                            .avatar ??
                                        '')
                                : Image.asset(
                                    Assets.profileImage,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                      ),
                    )
                  : Container(),
            ),
            onPressed: () {
              AppGetXController.to
                  .changeSelectedBottomBarScreen(selectedIndex: 2);
            },
          ),
          SizedBox(width: width / 70),
        ],
      ),
      body: RefreshIndicator(
        color: MissionDistributorColors.primaryColor,
        backgroundColor: MissionDistributorColors.secondaryColor,
        onRefresh: () async {
          MissionGetXController.to.read();
        },
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
            } else {}
            return Obx(
              () => ListView(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      start: width / 20,
                      end: width / 20,
                      top: height / 50,
                      bottom: height / 70,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.wallet,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.wallet_desc,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(height: height / 29),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // _selectedDoneMissions = true;
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color:
                                            MissionDistributorColors.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.totalEarningsIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .total_earnings,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(end: width / 50),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  '${_missionGetXController.money.value}\$',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 60,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // _selectedDoneMissions = true;
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color: MissionDistributorColors
                                            .primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.totalCoinsIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .total_coins,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(end: width / 50),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  '${_missionGetXController.points.value}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // _selectedDoneMissions = true;
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color: MissionDistributorColors
                                            .primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.overallAchievementIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .overall_achievement,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    end: width / 50,
                                                  ),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  'missions ${_missionGetXController.missionsCount.value.completedMissionsCount}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 60,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // _selectedDoneMissions = true;
                                      });
                                    },
                                    child: Container(
                                      height: height / 11.4,
                                      decoration: BoxDecoration(
                                        color:
                                            MissionDistributorColors.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                Assets.remainingMissionsIcon,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .remaining_missions,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    end: width / 50,
                                                  ),
                                                  child: const Divider(
                                                    color: Colors.white,
                                                    thickness: 3,
                                                  ),
                                                ),
                                                Text(
                                                  'mission ${_missionGetXController.missionsCount.value.remainingMissionsCount}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height / 100),
                        Text(
                          AppLocalizations.of(context)!.today_missions,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height / 100),
                        SizedBox(
                          height: height / 2.12,
                          child: GetX<MissionGetXController>(
                            builder: (controller) {
                              List<Mission> _controller =
                                  controller.remainingMissions.value;
                              if (_controller.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: _controller.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (!_selectedDoneMissions) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MissionDetailsScreen(
                                                mission: _controller[index],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsetsDirectional.only(
                                          top: height / 70,
                                        ),
                                        height: height / 5.5,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MissionDistributorColors
                                              .primaryColor,
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    30,
                                                  ),
                                                ),
                                                height: height / 4.9,
                                                width: double.infinity,
                                                child: _controller[index]
                                                        .images
                                                        .isNotEmpty
                                                    ? _controller[index]
                                                            .images[0]
                                                            .name
                                                            .contains('http')
                                                        ? Image.asset(
                                                            Assets.missionImage,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            NetworkLink(
                                                              link: _controller[
                                                                      index]
                                                                  .images[0]
                                                                  .name,
                                                            ).link,
                                                            fit: BoxFit.fill,
                                                          )
                                                    : Image.asset(
                                                        Assets.missionImage,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: AlignmentDirectional
                                                      .topCenter,
                                                  end: AlignmentDirectional
                                                      .bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            Container(
                                              alignment: AlignmentDirectional
                                                  .bottomStart,
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: width / 20,
                                                end: width / 20,
                                                top: height / 160,
                                                bottom: height / 80,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Text(
                                                _controller[index].title ??
                                                    AppLocalizations.of(
                                                            context)!
                                                        .no_has_title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (_connectionStatus.name == 'none') {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Center(
                                      child: Text(
                                        'Not Have Connection, Please Check Your Internet Connection',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (_controller.isEmpty) {
                                return const Center(
                                  child: Text('Not has Any Mission'),
                                );
                              } else {
                                return const Center(
                                  child: Text('Not has Any Mission'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
