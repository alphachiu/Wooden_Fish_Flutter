import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodenfish_bloc/repository/ads_repository.dart';
import 'package:woodenfish_bloc/repository/api/local_storage_setting_api.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bottom_tabbar_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';
import 'package:woodenfish_bloc/utils/app_config.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

import 'firebase/prod/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final settingApi =
      LocalStorageSettingApi(plugin: await SharedPreferences.getInstance());

  var configuredApp = AppConfig(
      environment: Environment.prod,
      appTitle: 'WoodenFish',
      child: MyApp(localSettingAPI: settingApi));

  ///LocalNotification init
  await WoodenFishUtil.internal().locationNotificationInit();
  MobileAds.instance.initialize();
  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  const MyApp({required this.localSettingAPI, super.key});
  final LocalStorageSettingApi localSettingAPI;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('appName = ${AppConfig.of(context).appTitle}');

    return MaterialApp(
      title: AppConfig.of(context).appTitle,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0Xff066eb2), foregroundColor: Colors.white),
      ),
      home: RepositoryProvider(
        create: (context) => WoodenRepository(woodenApi: localSettingAPI),
        child: MultiBlocProvider(providers: [
          BlocProvider<WoodFishWidgetBloc>(
              create: (BuildContext context) => WoodFishWidgetBloc(
                  woodenRepository:
                      RepositoryProvider.of<WoodenRepository>(context), adsRepository: RepositoryProvider.of<AdsRepository>(context))),
        ], child: const BottomTabBarPage()),
      ),
    );
  }
}
