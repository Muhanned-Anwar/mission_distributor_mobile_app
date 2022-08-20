import 'package:flutter/material.dart';
import 'package:mission_distributor/controllers/getX/app_getX_controller.dart';
import 'package:mission_distributor/controllers/getX/mission_getX_controller.dart';
import 'package:mission_distributor/core/res/assets.dart';
import 'package:mission_distributor/core/res/routes.dart';

import '../../../controllers/getX/do_mission_getX_controller.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/widgets/MyElevatedButton.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({Key? key}) : super(key: key);

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  late double width;
  late double height;

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 15,
  );
  double buttonHeight = 803 / 23.74;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MissionDistributorColors.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: const Icon(
              Icons.arrow_back_ios,
              color: MissionDistributorColors.primaryColor,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.only(top: height / 40),
          child: const Text(
            'My Rank',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: MissionDistributorColors.primaryColor,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonHeight = height / 23.74;
          } else {
            buttonHeight = height / 8;
          }
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: width / 15.28, vertical: height / 37),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height / 40),
                    Container(
                      height: height / 7.17,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(41),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.star1Image),
                          SizedBox(width: width / 35),
                          Image.asset(Assets.star2Image),
                          SizedBox(width: width / 35),
                          Image.asset(Assets.star3Image),
                          SizedBox(width: width / 35),
                          Image.asset(Assets.star2Image),
                          SizedBox(width: width / 35),
                          Image.asset(Assets.star1Image),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 46),
                    Container(
                      height: height / 3.67,
                      decoration: BoxDecoration(
                        color: MissionDistributorColors.primaryColor,
                        borderRadius: BorderRadius.circular(41),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: height / 23.7,
                          horizontal: width / 17.12,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Done Mission',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          height: height / 24,
                                          alignment: Alignment.center,
                                          child: Text(
                                            MissionGetXController.to.missionsCount.value.completedMissionsCount.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffF3CC30)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Coins',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          height: height / 24,

                                          alignment: Alignment.center,
                                          child: Text(
                                            MissionGetXController.to.points
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffF3CC30)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Gift',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          height: height / 24,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${AppGetXController.to.gift()}\$',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffF3CC30)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Wallet',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          height: height / 24,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${MissionGetXController.to.money.toString()}\$',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffF3CC30)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: height / 11.2,
                                width: width / 5.2,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '46%',
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height / 20),
                    const Text(
                      'Please wait!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MissionDistributorColors.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      child: const Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting Industry.',
                        style: TextStyle(
                          fontSize: 20,
                          color: MissionDistributorColors.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height / 20),
                    // MyElevatedButton(
                    //   onPressed: () async {
                    //     Navigator.pushReplacementNamed(context, Routes.doneScreen);
                    //   },
                    //   child: const Text(
                    //     'DONE',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w300,
                    //     ),
                    //   ),
                    //   height: buttonHeight,
                    //   width: width / 1.27,
                    //   borderRadiusGeometry: BorderRadius.circular(20),
                    //   gradient: const LinearGradient(
                    //     colors: [
                    //       MissionDistributorColors.primaryColor,
                    //       MissionDistributorColors.primaryColor,
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
