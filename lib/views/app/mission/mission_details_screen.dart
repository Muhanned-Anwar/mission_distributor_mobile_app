import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mission_distributor/controllers/getX/do_mission_getX_controller.dart';
import 'package:mission_distributor/controllers/getX/mission_getX_controller.dart';
import 'package:mission_distributor/models/missions/do_mission.dart';
import 'package:mission_distributor/models/network_link.dart';
import 'package:mission_distributor/models/url_link.dart';
import 'package:mission_distributor/views/app/mission/mission_complete_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/res/assets.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/widgets/MyElevatedButton.dart';
import '../../../models/missions/mission.dart';

// ignore: must_be_immutable
class MissionDetailsScreen extends StatefulWidget {
  Mission mission;

  MissionDetailsScreen({required this.mission, Key? key}) : super(key: key);

  @override
  State<MissionDetailsScreen> createState() => _MissionDetailsScreenState();
}

class _MissionDetailsScreenState extends State<MissionDetailsScreen> {
  late double width;
  late double height;
  double buttonHeight = 803 / 23.74;

  Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;
  DoMissionGetXController doMissionGetXController =
      Get.put(DoMissionGetXController());

  Future<File>? imageFile;
  File? _image;
  XFile? pickedFile;
  String result = '';
  ImagePicker? imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  double? _progressValue = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _url = Uri.parse(widget.mission.link);
    return Scaffold(
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
          'Mission Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
                Container(
                  height: height / 13,
                  alignment: Alignment.center,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 12, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MissionDistributorColors.primaryColor,
                  ),
                  child: Container(
                    child: Text(
                      widget.mission.title ?? 'No has title',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 150),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MissionDistributorColors.primaryColor,
                  ),
                  height: height / 5,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.mission.description ?? 'No has description',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 60),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  height: height / 3.2,
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
                        ),
                ),
                SizedBox(height: height / 50),
                Container(
                  margin: EdgeInsetsDirectional.only(start: width / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How to get the job done',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MissionDistributorColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: height / 100),
                      Container(
                        child: widget.mission.steps.isNotEmpty
                            ? SizedBox(
                                height: height / 7,
                                child: ListView.builder(
                                  itemCount: widget.mission.steps.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsetsDirectional.only(
                                        top: height / 100,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width / 19.45,
                                              height: height / 51,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: MissionDistributorColors
                                                    .primaryColor,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                (index + 1).toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width / 100),
                                            Text(
                                              // index == 0 ?
                                              widget.mission.steps[index],
                                              // : index == 1
                                              //     ? widget
                                              //         .mission.steps[index]
                                              //     : widget
                                              //         .mission.steps[index],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: MissionDistributorColors
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: height / 7,
                                child: const Center(
                                  child: Text(
                                    'No has steps',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          MissionDistributorColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: height / 50),
                      Visibility(
                        visible: isGoButtonVisible,
                        child: MyElevatedButton(
                          onPressed: () async {
                            print(widget.mission.link);
                            await _launchUrl(
                                widget.mission.link.contains('https://') ||
                                        widget.mission.link.contains('http://')
                                    ? widget.mission.link
                                    : UrlLink(link: widget.mission.link).link);
                            setState(() {
                              isGoButtonVisible = false;
                            });
                            // Navigator.pushNamed(context, Routes.signUpScreen);
                          },
                          child: const Text(
                            'GO',
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
                        replacement: MyElevatedButton(
                          onPressed: () async {
                            await selectPhotoFromGallery();
                            if (_image != null) {}
                          },
                          child: const Text(
                            'Submit screenshot',
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      this.pickedFile = pickedFile;
    });
    storeMission(image: _image!.path);
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<void> storeMission({required String image}) async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          value: _progressValue,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
    String money = MissionGetXController.to.money.value;

    doMissionGetXController.upload(
      filePath: image,
      doMission: DoMission(
        date: DateTime.now().toString(),
        missionId: widget.mission.id.toString(),
        screenShot: image,
      ),
      imageUploadResponse: ({
        required String message,
        required bool status,
        DoMission? doMission,
      }) {
        _changeProgressValue(value: status ? 1 : 0);
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MissionCompleteScreen(
              money: money.toString(),
              mission: widget.mission,
              imageUrl: widget.mission.images.isNotEmpty
                  ? widget.mission.images[0].name
                  : Assets.missionImage,
            ),
          ),
        );
      },
    );
    // Navigator.of(context).pop();
  }

  Future<void> _launchUrl(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw 'Could not launch $_url';
    }
  }
}
