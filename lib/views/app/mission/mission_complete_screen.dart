import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/do_mission_getX_controller.dart';
import 'package:mission_distributor/controllers/getX/mission_getX_controller.dart';
import 'package:mission_distributor/core/widgets/MyElevatedButton.dart';
import 'package:mission_distributor/models/missions/mission.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/res/assets.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../models/network_link.dart';
import '../../../models/url_link.dart';

// ignore: must_be_immutable
class MissionCompleteScreen extends StatefulWidget {
  Mission mission;
  String imageUrl;
  String money;

  MissionCompleteScreen(
      {required this.money,
      required this.mission,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  State<MissionCompleteScreen> createState() => _MissionCompleteScreenState();
}

class _MissionCompleteScreenState extends State<MissionCompleteScreen> {
  late double width;
  late double height;
  double buttonHeight = 803 / 23.74;

  Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 15,
  );
  late String missionMoney = MissionGetXController.to.money.value;
  late double rate = MissionGetXController.to.rate.value;
  late double wallet;

  @override
  void initState() {
    _url = widget.mission.link != null && widget.mission.link != ''
        ? Uri.parse(widget.mission.link)
        : Uri.parse('https://flutter.dev');
    DoMissionGetXController.to.totalPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MissionGetXController.to.read();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print(rate);
    print(widget.mission.points);
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
              color: Colors.blue,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mission Complete',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MissionDistributorColors.primaryColor,
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
            margin: EdgeInsets.symmetric(horizontal: width / 10.5),
            child: ListView(
              children: [
                SizedBox(height: height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Points',
                          style: textStyle,
                        ),
                        Obx(() {
                          return Text(
                            MissionGetXController.to.points.toString(),
                            style: textStyle,
                          );
                        }),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: height / 12,
                          width: width / 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: MissionDistributorColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '%${((100 / MissionGetXController.to.missionsCount.value.missionsCount) * MissionGetXController.to.missionsCount.value.completedMissionsCount).toString().split('.')[0]}',
                            style: const TextStyle(
                              color: MissionDistributorColors.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          '${MissionGetXController.to.missionsCount.value.missionsCount}\\${MissionGetXController.to.missionsCount.value.completedMissionsCount}',
                          style: const TextStyle(
                            color: MissionDistributorColors.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Wallet',
                          style: textStyle,
                        ),
                        Text(
                          (double.parse(widget.mission.points) / rate)
                              .toString(),
                          style: textStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height / 25),
                Container(
                  height: height / 5.352,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.mission.title ?? '',
                            style: const TextStyle(
                              color: MissionDistributorColors.primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: height / 50),
                          Text(
                            widget.mission.description ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: MissionDistributorColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 55),
                Container(
                  height: height / 18,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MissionDistributorColors.primaryColor,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await _launchUrl();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width / 1.7,
                          child: Text(
                            widget.mission.link.contains('https://') ||
                                widget.mission.link.contains('http://')
                                ? widget.mission.link
                                : UrlLink(link: widget.mission.link).link,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height / 55),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    height: height / 8.4,
                    child: widget.mission.images.isNotEmpty
                        ? widget.mission.images[0].name.contains('http')
                            ? Image.asset(
                                Assets.missionImage,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                NetworkLink(link: widget.mission.images[0].name)
                                    .link,
                                fit: BoxFit.fill,
                              )
                        : Image.asset(
                            Assets.missionImage,
                            fit: BoxFit.fill,
                          )),
                SizedBox(height: height / 15),
                Column(
                  children: [
                    Text(
                      'POINTS',
                      style: textStyle,
                    ),
                    Text(
                      widget.mission.points.toString(),
                      style: const TextStyle(
                        fontSize: 36,
                        color: MissionDistributorColors.primaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: height / 15),
                MyElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/wallet_screen');
                  },
                  child: const Text(
                    'Go Wallet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  height: buttonHeight,
                  width: width / 1.27,
                  borderRadiusGeometry: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      MissionDistributorColors.primaryColor,
                      MissionDistributorColors.primaryColor,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
