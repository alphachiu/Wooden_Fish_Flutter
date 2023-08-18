import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodenfish_bloc/repository/ad_client/ad_client.dart';
import 'package:woodenfish_bloc/repository/ads_repository.dart';
import 'package:woodenfish_bloc/repository/api/local_storage_setting_api.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bottom_tabbar_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/bloc/setting_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';
import 'package:woodenfish_bloc/utils/app_config.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';
import 'firebase/dev/firebase_options.dart';

//https://sebastien-arbogast.com/2022/05/02/multi-environment-flutter-projects-with-flavors/#Preparing_Your_Android_App

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final settingApi =
      LocalStorageSettingApi(plugin: await SharedPreferences.getInstance());

  var configuredApp = AppConfig(
      environment: Environment.dev,
      appTitle: '[Dev] WoodenFish',
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
              backgroundColor: Color(0Xff066eb2),
              foregroundColor: Colors.white),
        ),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<WoodenRepository>(
              create: (context) => WoodenRepository(woodenApi: localSettingAPI),
            ),
            RepositoryProvider<AdsRepository>(
              create: (context) => AdsRepository(adsClient: AdsClient()),
            ),
          ],
          child: MultiBlocProvider(providers: [
            BlocProvider<WoodFishWidgetBloc>(
                create: (BuildContext context) => WoodFishWidgetBloc(
                    woodenRepository:
                        RepositoryProvider.of<WoodenRepository>(context),
                    adsRepository:
                        RepositoryProvider.of<AdsRepository>(context))),
          ], child: const BottomTabBarPage()),
        )

        // RepositoryProvider(
        //   create: (context) => WoodenRepository(woodenApi: localSettingAPI),
        //   child: MultiBlocProvider(providers: [
        //     BlocProvider<WoodFishWidgetBloc>(
        //         create: (BuildContext context) => WoodFishWidgetBloc(
        //             woodenRepository:
        //                 RepositoryProvider.of<WoodenRepository>(context))),
        //   ], child: const BottomTabBarPage()),
        // ),
        );
  }
}
