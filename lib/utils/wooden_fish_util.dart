
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class WoodenFishUtil{

  static final WoodenFishUtil _instance = WoodenFishUtil.internal();
  WoodenFishUtil.internal();

  factory WoodenFishUtil(){
    return _instance;
  }

 Color getColorFromString(String color){

    Color?  bgColor;
   for (BgElement element in BgElement.values) {
     if (element.toString() == color) {
       switch (element) {
         case BgElement.none:
           bgColor = Colors.white;
           break;
         case BgElement.red:
           bgColor = Colors.red;
           break;
         case BgElement.orange:
           bgColor = Colors.orange;
           break;
         case BgElement.green:
           bgColor = Colors.green;
           break;
         case BgElement.yellow:
           bgColor = Colors.yellow;
           break;
         case BgElement.blue:
           bgColor = Colors.blue;
           break;
         case BgElement.indigo:
           bgColor = Colors.indigo;
           break;
         case BgElement.purple:
           bgColor = Colors.purple;
           break;
       }
       break;
     }
   }

   return bgColor!;

 }



}
