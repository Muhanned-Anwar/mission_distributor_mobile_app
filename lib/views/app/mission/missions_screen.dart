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

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({Key? key}) : super(key: key);

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> with Helpers{
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
    return RefreshIndicator(
      color: MissionDistributorColors.primaryColor,
      backgroundColor: MissionDistributorColors.secondaryColor,
      onRefresh: () async {
        MissionGetXController.to.read();
      },
      child: Scaffold(
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
                          child: UserPreferenceController()
                                      .userInformation
                                      .avatar !=
                                  ''
                              ?  !(_connectionStatus.name != 'none' || connection)
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
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
            } else {}
            return ListView(
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
                      // Row(
                      //   children: [
                      //     CircleAvatar(
                      //       radius: 30,
                      //       child: Assets.profileImage != ''
                      //           ? Align(
                      //               alignment: Alignment.center,
                      //               child: ClipRRect(
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 child: UserPreferenceController()
                      //                             .userInformation
                      //                             .avatar !=
                      //                         ''
                      //                     ? Image.network(
                      //                         UserPreferenceController()
                      //                                 .userInformation
                      //                                 .avatar ??
                      //                             '')
                      //                     : Image.asset(
                      //                         Assets.profileImage,
                      //                         fit: BoxFit.cover,
                      //                         width: 60,
                      //                         height: 60,
                      //                       ),
                      //               ),
                      //             )
                      //           : Container(),
                      //     ),
                      //     const SizedBox(width: 17),
                      //     Text(
                      //       UserPreferenceController().userInformation.name,
                      //       style: const TextStyle(
                      //         fontSize: 21,
                      //         fontWeight: FontWeight.w400,
                      //         color: MissionDistributorColors.primaryColor,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 7),
                      //     Container(
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(25),
                      //         color: MissionDistributorColors.primaryColor,
                      //       ),
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         _missionGetXController.points.toString(),
                      //         style: const TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w400,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: height / 29),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedDoneMissions = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: _selectedDoneMissions
                                        ? MissionDistributorColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _selectedDoneMissions
                                          ? Colors.white
                                          : MissionDistributorColors
                                              .primaryColor,
                                    ),
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
                                    _selectedDoneMissions = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: !_selectedDoneMissions
                                        ? MissionDistributorColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    'ToDo',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: !_selectedDoneMissions
                                          ? Colors.white
                                          : MissionDistributorColors
                                              .primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height / 29),
                      SizedBox(
                        height: height / 1.395,
                        child: GetX<MissionGetXController>(
                          builder: (controller) {
                            List<Mission> _controller = _selectedDoneMissions
                                ? controller.completedMissions.value
                                : controller.remainingMissions.value;
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
                                        borderRadius: BorderRadius.circular(10),
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
                                                    BorderRadius.circular(30),
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
                                                  Colors.black.withOpacity(0.5),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Container(
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            padding: EdgeInsetsDirectional.only(
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
                                                  AppLocalizations.of(context)!
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
                              return Scaffold(
                                body: Column(
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
                                ),
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
            );
          },
        ),
      ),
    );
  }
}
