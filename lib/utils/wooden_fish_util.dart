import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class WoodenFishUtil {
  static final WoodenFishUtil _instance = WoodenFishUtil.internal();
  WoodenFishUtil.internal();

  factory WoodenFishUtil() {
    return _instance;
  }

  WoodenFishSkinElement? getSkinElementFromString(String skinElement) {
    for (WoodenFishSkinElement element in WoodenFishSkinElement.values) {
      if (element.toString() == skinElement) {
        return element;
      }
    }
    return null;
  }

  WoodenFishBgElement? getBgElementFromString(String bgElement) {
    for (WoodenFishBgElement element in WoodenFishBgElement.values) {
      if (element.toString() == bgElement) {
        return element;
      }
    }
    return null;
  }

  WoodenFishSoundElement? getSoundElementFromString(String soundElement) {
    for (WoodenFishSoundElement element in WoodenFishSoundElement.values) {
      if (element.toString() == soundElement) {
        return element;
      }
    }
    return null;
  }

  Color getColorFromString(String colorName) {
    Color? bgColor = Colors.white;

    for (WoodenFishBgElement element in WoodenFishBgElement.values) {
      if (element.toString() == colorName) {
        switch (element) {
          case WoodenFishBgElement.none:
            bgColor = Colors.white;
            break;
          case WoodenFishBgElement.red:
            bgColor = Colors.red;
            break;
          case WoodenFishBgElement.orange:
            bgColor = Colors.orange;
            break;
          case WoodenFishBgElement.green:
            bgColor = Colors.green;
            break;
          case WoodenFishBgElement.yellow:
            bgColor = Colors.yellow;
            break;
          case WoodenFishBgElement.blue:
            bgColor = Colors.blue;
            break;
          case WoodenFishBgElement.indigo:
            bgColor = Colors.indigo;
            break;
          case WoodenFishBgElement.purple:
            bgColor = Colors.purple;
            break;

          case WoodenFishBgElement.bg01:
          case WoodenFishBgElement.bg02:
          case WoodenFishBgElement.bg03:
          case WoodenFishBgElement.bg04:
          case WoodenFishBgElement.bg05:
            bgColor = Colors.transparent;
            break;
        }
        break;
      }
    }

    return bgColor!;
  }

  Color getKnockTextColorFromString(String colorName) {
    Color? bgColor;
    for (WoodenFishBgElement element in WoodenFishBgElement.values) {
      if (element.toString() == colorName) {
        switch (element) {
          case WoodenFishBgElement.none:
            bgColor = Colors.black;
            break;
          case WoodenFishBgElement.red:
          case WoodenFishBgElement.orange:
          case WoodenFishBgElement.green:
          case WoodenFishBgElement.yellow:
          case WoodenFishBgElement.blue:
          case WoodenFishBgElement.indigo:
          case WoodenFishBgElement.purple:
            bgColor = Colors.white;
            break;

          case WoodenFishBgElement.bg01:
          case WoodenFishBgElement.bg02:
          case WoodenFishBgElement.bg03:
          case WoodenFishBgElement.bg04:
          case WoodenFishBgElement.bg05:
            bgColor = Colors.yellow;
            break;
        }
        break;
      }
    }

    return bgColor!;
  }

  Image? getBgImageFromString({required String colorName, double size = 0}) {
    Image? image;
    for (WoodenFishBgElement element in WoodenFishBgElement.values) {
      if (element.toString() == colorName) {
        switch (element) {
          case WoodenFishBgElement.bg01:
            image = Image(
              width: size == 0 ? null : size / 2,
              height: size == 0 ? null : size,
              fit: size == 0 ? BoxFit.fill : BoxFit.none,
              image: const AssetImage('assets/images/woodenFish_bg_01.jpg'),
            );

            break;
          case WoodenFishBgElement.bg02:
            image = Image(
              width: size == 0 ? null : size / 2,
              height: size == 0 ? null : size,
              fit: size == 0 ? BoxFit.fill : BoxFit.none,
              image: const AssetImage('assets/images/woodenFish_bg_02.jpg'),
            );
            break;
          case WoodenFishBgElement.bg03:
            image = Image(
              width: size == 0 ? null : size / 2,
              height: size == 0 ? null : size,
              fit: size == 0 ? BoxFit.fill : BoxFit.none,
              image: const AssetImage('assets/images/woodenFish_bg_03.jpg'),
            );
            break;
          case WoodenFishBgElement.bg04:
            image = Image(
              width: size == 0 ? null : size / 2,
              height: size == 0 ? null : size,
              fit: size == 0 ? BoxFit.fill : BoxFit.none,
              image: const AssetImage('assets/images/woodenFish_bg_04.jpg'),
            );
            break;
          case WoodenFishBgElement.bg05:
            image = Image(
              width: size == 0 ? null : size / 2,
              height: size == 0 ? null : size,
              fit: size == 0 ? BoxFit.fill : BoxFit.none,
              image: const AssetImage('assets/images/woodenFish_bg_05.jpg'),
            );
            break;

          default:
            break;
        }
        break;
      }
    }

    return image;
  }

  String getSoundNameFromString(String soundName) {
    String? soundNameStr;
     print('soundName = ${soundName}');
    for (WoodenFishSoundElement element in WoodenFishSoundElement.values) {
      if (element.toString() == soundName) {
        switch (element) {
          case WoodenFishSoundElement.sound01:
            soundNameStr = 'sounds/woodenFish_sound_01.wav';
            break;
          case WoodenFishSoundElement.sound02:
            soundNameStr = 'sounds/woodenFish_sound_02.mp3';
            break;
          case WoodenFishSoundElement.sound03:
            soundNameStr = 'sounds/woodenFish_sound_03.mp3';
            break;
          case WoodenFishSoundElement.sound04:
            soundNameStr = 'sounds/woodenFish_sound_04.mp3';
            break;
          case WoodenFishSoundElement.sound05:
            soundNameStr = 'sounds/woodenFish_sound_05.mp3';
            break;
          case WoodenFishSoundElement.sound06:
            soundNameStr = 'sounds/woodenFish_sound_06.mp3';
            break;
          case WoodenFishSoundElement.sound07:
            soundNameStr = 'sounds/woodenFish_sound_07.mp3';
            break;
          default:
            break;
        }
        break;
      }
    }
    return soundNameStr!;
  }

  Image getSkinImageFromString(String skinName) {
    Image? image;

    for (WoodenFishSkinElement element in WoodenFishSkinElement.values) {
      if (element.toString() == skinName) {
        switch (element) {
          case WoodenFishSkinElement.wood:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_wood.png'),
            );
            break;
          case WoodenFishSkinElement.wood01:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFsih_wood_01.png'),
            );
            break;

          case WoodenFishSkinElement.sky:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_sky.png'),
            );
            break;
          case WoodenFishSkinElement.copper:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_copper.png'),
            );
            break;
          case WoodenFishSkinElement.silver:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_silver.png'),
            );
            break;
          case WoodenFishSkinElement.gold:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_gold.png'),
            );
            break;
          case WoodenFishSkinElement.diamond:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_diamond.png'),
            );
            break;
          case WoodenFishSkinElement.sakura:
            image = const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/woodenFish_sakura.png'),
            );
            break;

          default:
            break;
        }
        break;
      }
    }

    return image!;
  }

  String transformationKnockCount(int count) {
    var resultForm = '';
    if (count >= 1000 && count < 1000000) {
      resultForm = "${(count / 1000).toStringAsFixed(1)}K";
    } else if (count >= 1000000 && count < 1000000000) {
      resultForm = "${(count / 1000000).toStringAsFixed(1)}M";
    } else if (count >= 1000000000 && count < 1000000000000) {
      resultForm = "${(count / 1000000000).toStringAsFixed(1)}B";
    } else {
      resultForm = count.toString();
    }
    return resultForm;
  }

  Future<String> getPrayAvatarPath() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    if (await Directory("$directory/userAvatar").exists() != true) {
      print("Directory not exist");
      Directory("$directory/userAvatar").createSync(recursive: true);
      return "$directory/userAvatar";
    } else {
      print("Directory exist");
      return "$directory/userAvatar";
    }
  }

  Future<Image?> getAvatarImage() async {
    Image? prayAvatar;
    try {
      // getting a directory path for saving
      String path = await getPrayAvatarPath();
      var imageList = Directory(path)
          .listSync()
          .where((e) => e.path.endsWith('.png'))
          .toList()
        ..sort(
            (l, r) => l.statSync().modified.compareTo(r.statSync().modified));

      var videosPathList = imageList.map((e) => e.path).toList();
      print('videosPathList = ${videosPathList.toString()}');
      File avatarFile = File(videosPathList.last.toString());

      if (await avatarFile.exists()) {
        prayAvatar = Image.file(
          avatarFile,
          width: 200,
          height: 200,
        );
        print('getAvatarImage = ${prayAvatar.image}');
        return prayAvatar;
      }
    } catch (e) {
      print('getAvatarImage error = $e');
    }
    return null;
  }
}
