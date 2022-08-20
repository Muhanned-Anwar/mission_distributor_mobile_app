import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mission_distributor/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:mission_distributor/core/res/routes.dart';
import '../core/res/assets.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        String route = UserPreferenceController().loggedIn
            ? Routes.homeScreen
            : Routes.authenticationScreen;
        Navigator.pushReplacementNamed(
          context,
          route
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  double imageHeight = 803.6363636363636 / 6.3;
  double imageWidth = 392.72727272727275 / 2.8337;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        imageHeight = height / 4.78;
        imageWidth = width / 2.8337;
      } else {
        imageHeight = height / 3;
        imageWidth = width;
      }
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height / 2.7),
                Image.asset(
                  Assets.logoLaunch,
                  filterQuality: FilterQuality.high,
                  width: imageWidth,
                  height: imageHeight,
                ),

                SizedBox(height: height / 10),
                Image.asset(
                  Assets.launchScreenImage,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
