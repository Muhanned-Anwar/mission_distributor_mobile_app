import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/app_getX_controller.dart';
import 'package:mission_distributor/controllers/getX/do_mission_getX_controller.dart';
import 'package:mission_distributor/controllers/storage/network/api/controllers/auth_api_controller.dart';
import 'package:mission_distributor/core/res/assets.dart';
import 'package:mission_distributor/core/res/mission_distributor_colors.dart';
import 'package:mission_distributor/core/res/routes.dart';
import 'package:mission_distributor/core/widgets/MyElevatedButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controllers/getX/language_change_notifier_getX.dart';
import '../../controllers/getX/mission_getX_controller.dart';
import '../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../core/utils/helpers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late double width;
  late double height;

  final TextStyle _textStyle = const TextStyle(
    fontSize: 21,
    color: MissionDistributorColors.primaryColor,
    fontWeight: FontWeight.w300,
  );

  String? _selectedLanguage;
  final _languagesList = ['العربية', 'English'];

  @override
  void initState() {
    super.initState();
    if (LanguageChangeNotifierGetX.to.languageCode == 'ar') {
      _selectedLanguage = 'العربية';
    } else {
      _selectedLanguage = 'English';
    }
  }

  double itemSize = 800 / 6;
  double? _progressValue = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: MissionDistributorColors.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            // color: MissionDistributorColors.primaryColor,
            // height: 0.5,
            child: LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: MissionDistributorColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.editProfileScreen);
            },
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            itemSize = height / 15;
          } else {
            itemSize = height / 6;
          }
          return ListView(
            children: [
              SizedBox(height: height / 40),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width / 14.2),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child:
                          UserPreferenceController().userInformation.avatar !=
                                  ''
                              ? Image.network(
                                  UserPreferenceController()
                                          .userInformation
                                          .avatar ??
                                      '',
                                  height: height / 11.5,
                                  width: height / 11.5,
                                )
                              : Image.asset(
                                  Assets.profileImage,
                                  fit: BoxFit.cover,
                                  width: width / 5.5,
                                  height: height / 11.5,
                                ),
                    ),
                    SizedBox(height: height / 60),
                    Text(
                      UserPreferenceController().userInformation.name,
                      style: _textStyle,
                    ),
                    SizedBox(height: height / 70),
                    Text(
                      UserPreferenceController().userInformation.mobile == ''
                          ? 'There is no mobile number'
                          : UserPreferenceController()
                              .userInformation
                              .mobile
                              .toString(),
                      style: _textStyle,
                    ),
                    SizedBox(height: height / 150),
                    Text(
                      UserPreferenceController().userInformation.email,
                      style: _textStyle,
                    ),
                    SizedBox(height: height / 30),

                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: height / 40),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width / 14.2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MyElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'COINS',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: MissionDistributorColors.primaryColor,
                                  ),
                                ),
                                borderSide: const BorderSide(
                                  color: MissionDistributorColors.primaryColor,
                                  width: 1,
                                ),
                                borderRadiusGeometry: BorderRadius.circular(14),
                                width: width / 4,
                                height: height / 25,
                              ),
                              SizedBox(width: width / 21),
                              MyElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.rankScreen);
                                },
                                child: const Text(
                                  'RANK',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: MissionDistributorColors.primaryColor,
                                  ),
                                ),
                                borderSide: const BorderSide(
                                  color: MissionDistributorColors.primaryColor,
                                  width: 1,
                                ),
                                borderRadiusGeometry: BorderRadius.circular(14),
                                width: width / 4,
                                height: height / 25,
                              ),
                            ],
                          ),
                          SizedBox(height: height / 100),
                          Row(
                            children: [
                              MyElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  MissionGetXController.to.points.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    MissionDistributorColors.primaryColor,
                                    MissionDistributorColors.primaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderSide: const BorderSide(
                                  color: MissionDistributorColors.primaryColor,
                                  width: 1,
                                ),
                                borderRadiusGeometry: BorderRadius.circular(14),
                                width: width / 4,
                                height: height / 25,
                              ),
                              SizedBox(width: width / 21),
                              MyElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  AppGetXController.to.rank.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    MissionDistributorColors.primaryColor,
                                    MissionDistributorColors.primaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderSide: const BorderSide(
                                  color: MissionDistributorColors.primaryColor,
                                  width: 1,
                                ),
                                borderRadiusGeometry: BorderRadius.circular(14),
                                width: width / 4,
                                height: height / 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width / 14.2),
                      height: height / 12.86,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.logo,
                            width: width / 20,
                            height: height / 40,
                            color: MissionDistributorColors.primaryColor,
                          ),
                          SizedBox(width: width / 60),
                          const Padding(
                            padding: EdgeInsetsDirectional.only(top: 8),
                            child: Text(
                              'Missions zone',
                              style: TextStyle(
                                color: MissionDistributorColors.primaryColor,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height / 25),
                    MyElevatedButton(
                      onPressed: () {},
                      child: SizedBox(
                        height: height / 12.86,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: width / 20,
                              color: MissionDistributorColors.primaryColor,
                            ),
                            SizedBox(width: width / 60),
                            const Padding(
                              padding: EdgeInsetsDirectional.only(top: 8),
                              child: Text(
                                'General Knowledge',
                                style: TextStyle(
                                  color: MissionDistributorColors.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        AppGetXController.to.changeSelectedBottomBarScreen(selectedIndex: 0);
                      },
                      child: SizedBox(
                        height: height / 12.86,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.track_changes,
                              size: width / 20,
                              color: MissionDistributorColors.primaryColor,
                            ),
                            SizedBox(width: width / 60),
                            const Padding(
                              padding: EdgeInsetsDirectional.only(top: 8),
                              child: Text(
                                'Missions',
                                style: TextStyle(
                                  color: MissionDistributorColors.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.walletScreen);
                      },
                      child: SizedBox(
                        height: height / 12.86,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wallet_giftcard,
                              size: width / 20,
                              color: MissionDistributorColors.primaryColor,
                            ),
                            SizedBox(width: width / 60),
                            const Padding(
                              padding: EdgeInsetsDirectional.only(top: 8),
                              child: Text(
                                'Wallet',
                                style: TextStyle(
                                  color: MissionDistributorColors.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 14.2),
                      child: const Divider(
                        color: MissionDistributorColors.primaryColor,
                        thickness: 1,
                      ),
                    ),
                    // SizedBox(height: height / 160),

                    // Change Language
                    SizedBox(
                      width: double.infinity,
                      height: itemSize,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          customButton: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width / 12.27,
                              ),
                              const Icon(
                                Icons.language,
                                color: MissionDistributorColors.primaryColor,
                              ),
                              SizedBox(width: width / 19.63),
                              Text(
                                AppLocalizations.of(context)!.lang,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: MissionDistributorColors.primaryColor,
                                ),
                              ),
                              const Spacer(flex: 1),
                              Text(
                                _selectedLanguage ?? '',
                                style:
                                const TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                              SizedBox(width: width / 28),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: MissionDistributorColors.primaryColor,
                              ),
                              SizedBox(width: width / 10.9),
                            ],
                          ),
                          items: _languagesList.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          isExpanded: true,
                          value: _selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              _selectedLanguage = value as String;
                              if (value == 'English') {
                                LanguageChangeNotifierGetX.to
                                    .changeLanguage(languageCode: 'en');
                              } else if (value == 'العربية') {
                                LanguageChangeNotifierGetX.to
                                    .changeLanguage(languageCode: 'ar');
                              }
                            });
                          },
                          buttonHeight: 40,
                          itemHeight: 40,
                        ),
                      ),
                    ),

                    // Logout
                    ElevatedButton(
                      onPressed: () async => signUp(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: itemSize,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width / 22,
                            ),
                            const Icon(
                              Icons.logout,
                              color: MissionDistributorColors.primaryColor,
                            ),
                            SizedBox(width: width / 19.63),
                            Text(
                              AppLocalizations.of(context)!.logout,
                              style: const TextStyle(
                                fontSize: 17,
                                color: MissionDistributorColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future signUp() async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => const Center(),
    );
    bool status = await AuthApiController().logout(context);
    _changeProgressValue(value: status ? 1 : 0);

    if (status) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.logout_successfully);
      UserPreferenceController().logout();
      Navigator.pushReplacementNamed(context, Routes.authenticationScreen);
    } else {
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.logout_failed,
          error: true);
    }
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}
