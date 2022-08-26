import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mission_distributor/controllers/storage/network/api/controllers/auth_api_controller.dart';
import '../../core/res/mission_distributor_colors.dart';
import '../../core/res/routes.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/MyElevatedButton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late double width;
  late double height;

  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;

  String? _usernameError;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  List<DropdownMenuItem> citiesItem = [];

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  double? _progressValue = 0;
  double buttonSize = 803.6363636363636 / 16;
  double bottomSizeBox = 803.6363636363636 / 3.4197;
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool _isObscureOld = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.sign_up,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      backgroundColor: MissionDistributorColors.scaffoldBackground,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonSize = height / 16;
            bottomSizeBox = height / 4;
          } else {
            buttonSize = height / 8;
            bottomSizeBox = height / 7;
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: width,
            height: height,
            alignment: Alignment.center,
            child: ListView(
              children: [
                LinearProgressIndicator(
                  value: _progressValue,
                  backgroundColor: Colors.transparent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height / 9.68),
                    TextField(
                      controller: _usernameTextController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.name,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: MissionDistributorColors.textFieldColor,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: ThemeData()
                                    .inputDecorationTheme
                                    .focusedBorder
                                    ?.borderSide
                                    .color ??
                                MissionDistributorColors.primaryColor,
                          ),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
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
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: MissionDistributorColors.textFieldColor,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: MissionDistributorColors.primaryColor),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
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
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(!_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),                        hintText: AppLocalizations.of(context)!.password,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: MissionDistributorColors.textFieldColor,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: MissionDistributorColors.primaryColor),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        errorText: _passwordError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    TextField(
                      controller: _confirmPasswordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureConfirm,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(!_isObscureConfirm
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscureConfirm = !_isObscureConfirm;
                              });
                            }),                        hintText:
                            AppLocalizations.of(context)!.confirm_password,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: MissionDistributorColors.textFieldColor,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: MissionDistributorColors.primaryColor),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        errorText: _confirmPasswordError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 42.29),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        AppLocalizations.of(context)!.password_length,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: height / 17.85),
                    MyElevatedButton(
                      onPressed: () async => performSignUp(),
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      height: buttonSize,
                      width: width,
                      borderRadiusGeometry: BorderRadius.circular(15),
                      marginHorizontal: width / 8.72,
                      gradient: const LinearGradient(
                        colors: [
                          MissionDistributorColors.primaryColor,
                          MissionDistributorColors.primaryColor
                        ],
                      ),
                    ),
                    SizedBox(height: bottomSizeBox),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.already_have_an_account,
                          style: const TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.signInScreen);
                          },
                          child: Text(AppLocalizations.of(context)!.sign_in),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _changeProgressValue({required double? value}) {
    setState(() {
      _progressValue = value;
    });
  }

  Future<void> performSignUp() async {
    if (checkData()) {
      await signUp();
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
    bool email = checkEmail();
    bool password = checkPassword();
    bool confirmPassword = checkConfirmPassword();

    setState(() {
      _usernameError =
          !username ? AppLocalizations.of(context)!.enter_username : null;
      _emailError = !email ? AppLocalizations.of(context)!.enter_email : null;
      _passwordError =
          !password ? AppLocalizations.of(context)!.enter_password : null;
      _confirmPasswordError = !confirmPassword
          ? AppLocalizations.of(context)!.enter_confirm_password
          : null;
    });
    if (username && email && password && confirmPassword) {
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

  bool checkEmail() {
    if (_emailTextController.text.isNotEmpty) {
      if (_emailTextController.text.contains('@')) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_correct_email,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkPassword() {
    if (_passwordTextController.text.isNotEmpty) {
      if (_passwordTextController.text.length >= 9) {
        return true;
      } else {
        showSnackBar(
            context: context,
            message: 'Password must be greater than or equal to 9',
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkConfirmPassword() {
    if (_confirmPasswordTextController.text.isNotEmpty) {
      if (_confirmPasswordTextController.text.length >= 4) {
        if (_confirmPasswordTextController.text ==
            _passwordTextController.text) {
          return true;
        } else {
          showSnackBar(
              context: context,
              message:
                  AppLocalizations.of(context)!.two_password_are_not_equaled,
              error: true,
              time: 1);
          return false;
        }
      } else {
        showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.enter_correct_password,
            error: true,
            time: 1);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> signUp() async {
    _changeProgressValue(value: null);
    showDialog(context: context, builder: (context) => Container());
    bool status = await AuthApiController().register(
        name: _usernameTextController.text,
        email: _emailTextController.text,
        password: _passwordTextController.text,
        context: context);
    _changeProgressValue(value: status ? 1 : 0);
    if (status) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sign_up_successfully);
      await login();
      // Navigator.pushReplacementNamed(context, Routes.signInScreen);
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sign_up_failed,
          error: true);
      Navigator.pop(context);
    }
  }

  Future<void> login() async {
    _changeProgressValue(value: null);
    showDialog(
      context: context,
      builder: (context) => const Center(),
    );
    bool status = await AuthApiController().login(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
    );
    _changeProgressValue(value: status ? 1 : 0);
    if (status) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.login_successfully);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
    } else {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.login_failed,
          error: true);
      Navigator.pop(context);
    }
  }

}
