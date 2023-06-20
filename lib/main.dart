import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mooden Fish',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0Xff066eb2),
              foregroundColor: Colors.white),
        ),
        home: BottomTabBarView());
  }
}
