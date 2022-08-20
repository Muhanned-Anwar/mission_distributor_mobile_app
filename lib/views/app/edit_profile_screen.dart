import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mission_distributor/controllers/storage/network/api/controllers/auth_api_controller.dart';
import 'package:mission_distributor/models/auth/User.dart';

import '../../../../controllers/storage/local/prefs/user_preference_controller.dart';
import '../../../../core/res/assets.dart';
import '../../../../core/res/routes.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/widgets/MyElevatedButton.dart';
import '../../core/res/mission_distributor_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _phoneTextEditingController;
  late TextEditingController _addressTextEditingController;

  late TextEditingController _birthDateTextEditingController;

  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _birthDateError;

  ImagePicker? imagePicker;
  XFile? _pickedFile;

  late String profileImage;


  late String gender;
  String? _selectedGender;
  final _genderList = ['Male', 'Female'];

  late String country;
  String? _selectedCountry;
  final _countryList = [
    'Palestine',
    'Jordan',
    'Egypt',
    'Syria',
    'Iraq',
    'Saudi Arabia',
    'UAE',
    'Kuwait',
    'Diameter'
  ];
  double itemSize = 392.72727272727275 / 6;



  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _birthDateTextEditingController = TextEditingController();
    _usernameTextController.text =
        UserPreferenceController().userInformation.name;
    _emailTextController.text =
        UserPreferenceController().userInformation.email;
    _phoneTextEditingController.text =
        UserPreferenceController().userInformation.mobile ?? '';

    gender = UserPreferenceController().userInformation.gender ?? '';
    _birthDateTextEditingController.text =
        UserPreferenceController().userInformation.dob ?? '';

    imagePicker = ImagePicker();
    profileImage = UserPreferenceController().userInformation.avatar ?? '';

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
      print(_connectionStatus.name);
    });
  }


  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _phoneTextEditingController.dispose();
    _birthDateTextEditingController.dispose();
    super.dispose();
  }

  double imageHeight = 803.6363636363636 / 9.34;
  double editTextSize = 803.6363636363636 / 12.36;
  double buttonSize = 803.6363636363636 / 16;
  double? _progressValue = 0;

  bool firstBuild = true;



  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    if (firstBuild) {
      firstBuild = false;
      if (gender == 'Male') {
        _selectedGender = AppLocalizations.of(context)!.gender_male;
      } else if (gender == 'Female') {
        _selectedGender = AppLocalizations.of(context)!.gender_female;
      }
      if(country != ''){
        _selectedCountry = country;
      }
    }
    _genderList[0] = AppLocalizations.of(context)!.gender_male;
    _genderList[1] = AppLocalizations.of(context)!.gender_female;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.7),
          child: IconButton(
            color: Colors.grey,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 15,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.edit_profile,
          style: const TextStyle(fontSize: 17, color: Colors.black),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            imageHeight = height / 9.34;
            editTextSize = height / 14;
            buttonSize = height / 16;
            itemSize = height / 12;

          } else {
            imageHeight = height / 5;
            editTextSize = height / 6;
            buttonSize = height / 8;
            itemSize = height / 6;

          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: width / 15.1),
            child: ListView(
              children: [
                LinearProgressIndicator(
                  value: _progressValue,
                  color: MissionDistributorColors.primaryColor,
                  backgroundColor: Colors.grey.shade400,
                  minHeight: 1,
                ),
                SizedBox(height: height / 20),

                // Profile Image
                GestureDetector(
                  onTap: selectPhotoFromGallery,
                  onLongPress: capturePhotoFromCamera,
                  child: Container(
                    alignment: Alignment.center,
                    width: width / 4.56,
                    height: imageHeight,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            _pickedFile != null
                                ? Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.file(
                                  File(_pickedFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                                : profileImage != ''
                                ? _connectionStatus.name != 'none' ? Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(50),
                                child: Image.network(
                                  UserPreferenceController()
                                      .userInformation
                                      .avatar ?? '',
                                  fit: BoxFit.cover,
                                  width: 86,
                                  height: 86,
                                ),
                              ),
                            ):Container()
                                : Container(),
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 27.7),

                // Name
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _usernameTextController,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.name),
                      errorText: _usernameError,
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Email
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _emailTextController,
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.email),
                      errorText: _emailError,
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Phone number
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _phoneTextEditingController,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.phone_number),
                      errorText: _phoneError,
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Birth Of Date
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: editTextSize,
                  child: TextField(
                    controller: _birthDateTextEditingController,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.birthDate),
                      errorText: _birthDateError,
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.pink,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height/40),

                // Gender
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: SizedBox(
                    width: double.infinity,
                    height: itemSize,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Container(
                              child: Image.asset(
                                Assets.genderIcon,
                              ),
                            ),
                            SizedBox(width: width / 19.63),
                            Container(
                              child: Text(
                                AppLocalizations.of(context)!.gender,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              _selectedGender ?? '',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            SizedBox(width: width / 28),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.pink,
                            ),
                          ],
                        ),
                        items: _genderList.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        isExpanded: true,
                        value: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value as String;
                            if (_selectedGender == 'ذكر') {
                              gender = 'Male';
                            } else if (_selectedGender == 'انثى') {
                              gender = 'Female';
                            }
                          });
                        },
                        buttonHeight: 40,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),


                SizedBox(height: height / 18.689),

                // Save
                MyElevatedButton(
                  onPressed: () async => await performUpdateUserInformation(),
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  height: buttonSize,
                  width: width / 1.57,
                  borderRadiusGeometry: BorderRadius.circular(10),
                  marginHorizontal: width / 8.72,
                  borderSide: BorderSide(color: Colors.pink.shade100),
                  gradient: const LinearGradient(
                    colors: [
                      MissionDistributorColors.thirdColor,
                      MissionDistributorColors.primaryColor,
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.changePasswordScreen);
                  },
                  child: Text(AppLocalizations.of(context)!.change_password),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> performUpdateUserInformation() async {
    if (checkData()) {
      await updateUserInformation(user: await readData());
    }
  }


  bool checkData() {
    if (checkFieldError()) {
      return true;
    }
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.enter_required_data,
        error: true,
        time: 1);
    return false;
  }

  bool checkFieldError() {
    bool username = checkUsername();
    bool phone = checkPhoneNumber();
    // bool address = checkAddress();
    bool gender = checkGender();
    bool birthDate = checkBirthDate();
    setState(() {
      _usernameError =
      !username ? AppLocalizations.of(context)!.enter_username : null;
      _phoneError = !phone ? AppLocalizations.of(context)!.phone_number : null;
      // _addressError = !address ? AppLocalizations.of(context)!.enter_address : null;
      _birthDateError =
      !birthDate ? AppLocalizations.of(context)!.enter_birthdate : null;
    });
    if (username && phone && gender && birthDate) {
      return true;
    } else {
      return false;
    }
  }

  bool checkUsername() {
    if (_usernameTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkPhoneNumber() {
    if (_phoneTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkAddress() {
    if (_addressTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkGender() {
    if (gender.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkBirthDate() {
    if (_birthDateTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }


  Future<User> readData() async {
    User user = User();
    user.name = _usernameTextController.text;
    user.mobile = _phoneTextEditingController.text;
    user.email = _emailTextController.text;
    user.gender = gender;
    user.dob = _birthDateTextEditingController.text;

    if (_pickedFile != null) {
      user.avatar = _pickedFile!.path;
    } else {
      user.avatar = UserPreferenceController().userInformation.avatar;
    }
    return user;
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<String> uploadImage() async {
    // _changeProgressValue(value: null);
    // return ImageGetXController.to.uploadProfileImage(
    //     uploadListener: ({
    //       message,
    //       reference,
    //       required bool status,
    //       required TaskState taskState,
    //     }) {
    //       if (taskState == TaskState.running) {
    //         _changeProgressValue(value: null);
    //       } else if (taskState == TaskState.success) {
    //         _changeProgressValue(value: 1);
    //         showSnackBar(
    //           context: context,
    //           message:
    //               AppLocalizations.of(context)!.image_uploaded_successfully,
    //         );
    //       } else if (taskState == TaskState.error) {
    //         _changeProgressValue(value: 0);
    //         showSnackBar(
    //             context: context,
    //             message: AppLocalizations.of(context)!.image_uploaded_failed,
    //             error: true);
    //       }
    //     },
    //     file: File(_pickedFile!.path));
    return '';
  }

  Future<void> updateUserInformation({required User user}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: MissionDistributorColors.primaryColor,
        ),
      ),
    );
    AuthApiController().updateProfile(
        filePath: user.avatar ?? '',
        updateProfile: ({
          required String message,
          required bool status,
          User? user,
        }) {
          _changeProgressValue(value: status ? 1 : 0);

          if(status){
            showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!.profile_update_succeeded);
          }else{
            showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!.profile_update_failed);
          }

        },
        user: user);
    //
    // bool status = await FbFireStoreController()
    //     .updateUser(context: context, customer: await readData());
    // Navigator.pop(context);
    // if (true) {
    //   showSnackBar(
    //       context: context,
    //       message: AppLocalizations.of(context)!.profile_update_succeeded);
    // } else {
    //   showSnackBar(
    //       context: context,
    //       message: AppLocalizations.of(context)!.image_uploaded_failed,
    //       error: true);
    // }
  }

  Future<void> selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> capturePhotoFromCamera() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }
}
