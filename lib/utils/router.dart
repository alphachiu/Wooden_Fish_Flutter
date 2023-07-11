import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woodenfish_bloc/ui/home/widgets/auto_setting/auto_setting_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/person_info_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/woodfish_widget.dart';
import 'package:woodenfish_bloc/utils/route_paths.dart';

import '../ui/home/widgets/setting_widget/setting_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.woodenFish:
        return MaterialPageRoute(
            builder: (context) => WoodFishWidgetPage(), settings: settings);
      case RoutePaths.setting:
        return MaterialPageRoute(
            builder: (_) => SettingWidgetPage(), settings: settings);
      case RoutePaths.autoSetting:
        return MaterialPageRoute(
            builder: (_) => AutoSettingPage(), settings: settings);

      case RoutePaths.personInfo:
        return MaterialPageRoute(
            builder: (_) => PersonInfoPage(), settings: settings);

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('not find any pages：${settings.name}'),
                  ),
                ));
    }
  }
}
