import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/storage/local/prefs/user_preference_controller.dart';
import 'controllers/getX/language_change_notifier_getX.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'controllers/storage/local/prefs/app_settings_prefs.dart';
import 'controllers/storage/network/firebase/controllers/fb_notifications.dart';
import 'core/material_app_routes.dart';
import 'core/mission_distributor_localizations.dart';
import 'core/mission_distributor_theme.dart';
import 'core/res/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsPrefs().initPreferences();
  await UserPreferenceController().initSharedPreferences();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageChangeNotifierGetX _languageChangeNotifierGetX =
      Get.put(LanguageChangeNotifierGetX());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: MissionDistributorLocalizations.languages,
        locale: Locale(_languageChangeNotifierGetX.languageCode),
        title: 'MissionDistributor',
        theme: MissionDistributorTheme.missionDistributorTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.launchScreen,
        routes: MaterialAppRoutes.routes(),
      ),
    );
  }
}
