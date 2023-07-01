import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodenfish_bloc/repository/api/local_storage_setting_api.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_bloc.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bottom_tabbar_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/bloc/setting_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingApi =
      LocalStorageSettingApi(plugin: await SharedPreferences.getInstance());
  runApp(MyApp(localSettingAPI: settingApi));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.localSettingAPI, super.key});
  final LocalStorageSettingApi localSettingAPI;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('main');
    return MaterialApp(
      title: 'Mooden Fish',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0Xff066eb2), foregroundColor: Colors.white),
      ),
      home: RepositoryProvider(
        create: (context) => WoodenRepository(woodenApi: localSettingAPI),
        child: MultiBlocProvider(providers: [
          BlocProvider<WoodfishWidgetBloc>(
              create: (BuildContext context) => WoodfishWidgetBloc(
                  woodenRepository:
                      RepositoryProvider.of<WoodenRepository>(context))),
          BlocProvider<BottomTabBarBloc>(
              create: (BuildContext context) => BottomTabBarBloc(
                  woodenRepository:
                      RepositoryProvider.of<WoodenRepository>(context))),
        ], child: const BottomTabBarPage()),
      ),
    );
  }
}
