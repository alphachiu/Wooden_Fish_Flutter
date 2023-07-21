import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodenfish_bloc/repository/api/local_storage_setting_api.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bottom_tabbar_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingApi =
      LocalStorageSettingApi(plugin: await SharedPreferences.getInstance());

  settingApi.currentChannel = APPChannel.dev;

  runApp(MyApp(localSettingAPI: settingApi));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.localSettingAPI, super.key});
  final LocalStorageSettingApi localSettingAPI;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('appName = ${localSettingAPI.appConfig.appName}');

    return MaterialApp(
      title: 'Wooden Fish',
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
                      RepositoryProvider.of<WoodenRepository>(context))),
        ], child: const BottomTabBarPage()),
      ),
    );
  }
}
