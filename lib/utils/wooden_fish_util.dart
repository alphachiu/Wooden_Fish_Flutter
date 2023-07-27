import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<Image?> getAvatarImage(String photoName) async {
    Image? prayAvatar;
    try {
      // getting a directory path for saving
      String path = await getPrayAvatarPath();
      var imageList = Directory(path)
          .listSync()
          .where((e) => e.path.contains(photoName))
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

  Future<Image?> saveAvatarPhoto(String photoName) async {
    try {
      ImagePicker picker = ImagePicker();
      // using your method of getting an image
      XFile? image = await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 10)
          .catchError((error) {
        print("ImagePicker error = $error");
        if (error.toString().contains("The user did not allow photo access")) {
          print("The user did not allow photo access");

          return null;
        }
      });
      print('image path = ${image?.path}');
      if (image == null) {
        print('cancel update AvatarImag');
        return null;
      }
      File imageFile = File(image.path);
      if (await imageFile.exists()) {
        // getting a directory path for saving
        String path = await WoodenFishUtil.internal().getPrayAvatarPath();
        // copy the file to a new path
        await imageFile.copy('$path/$photoName');
        return Image.file(imageFile);
      }
    } on FormatException catch (e) {
      return null;
    }
    return null;
  }

  LinearGradient getLinearGradientFrom(WoodenFishLevelElement level) {
    LinearGradient? gradient;
    switch (level) {
      case WoodenFishLevelElement.lv01:
      case WoodenFishLevelElement.lv02:
      case WoodenFishLevelElement.lv03:
        gradient = const LinearGradient(colors: [
          Colors.white,
        ], stops: [
          1
        ]);
        break;
      case WoodenFishLevelElement.lv04:
      case WoodenFishLevelElement.lv05:
      case WoodenFishLevelElement.lv06:
      case WoodenFishLevelElement.lv07:
        gradient = const LinearGradient(colors: [
          Colors.black,
          Colors.white,
          Colors.yellow,
        ], stops: [
          0.2,
          0.6,
          1,
        ]);
        break;
      case WoodenFishLevelElement.lv08:
      case WoodenFishLevelElement.lv09:
      case WoodenFishLevelElement.lv10:
      case WoodenFishLevelElement.lv11:
      case WoodenFishLevelElement.lv12:
      case WoodenFishLevelElement.lv13:
      case WoodenFishLevelElement.lv14:
      case WoodenFishLevelElement.lv15:
        gradient = const LinearGradient(colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple
        ], stops: [
          0.2,
          0.3,
          0.4,
          0.5,
          0.6,
          0.7,
          1
        ]);
        break;

      case WoodenFishLevelElement.lv16:
      case WoodenFishLevelElement.lv17:
      case WoodenFishLevelElement.lv18:
      case WoodenFishLevelElement.lv19:
      case WoodenFishLevelElement.lv20:
      case WoodenFishLevelElement.lv21:
      case WoodenFishLevelElement.lv22:
      case WoodenFishLevelElement.lv23:
      case WoodenFishLevelElement.lv24:
      case WoodenFishLevelElement.lv25:
      case WoodenFishLevelElement.lv26:
      case WoodenFishLevelElement.lv27:
      case WoodenFishLevelElement.lv28:
      case WoodenFishLevelElement.lv29:
      case WoodenFishLevelElement.lv30:
      case WoodenFishLevelElement.lv31:
      case WoodenFishLevelElement.lv32:
      case WoodenFishLevelElement.lv33:
      case WoodenFishLevelElement.lv34:
      case WoodenFishLevelElement.lv35:
      case WoodenFishLevelElement.lv36:
      case WoodenFishLevelElement.lv37:
      case WoodenFishLevelElement.lv38:
      case WoodenFishLevelElement.lv39:
      case WoodenFishLevelElement.lv40:
      case WoodenFishLevelElement.lv41:
      case WoodenFishLevelElement.lv42:
      case WoodenFishLevelElement.lv43:
      case WoodenFishLevelElement.lv44:
      case WoodenFishLevelElement.lv45:
      case WoodenFishLevelElement.lv46:
      case WoodenFishLevelElement.lv47:
      case WoodenFishLevelElement.lv48:
      case WoodenFishLevelElement.lv49:
      case WoodenFishLevelElement.lv50:
        gradient = const LinearGradient(colors: [
          Colors.yellow,
        ], stops: [
          1
        ]);
        break;
      default:
        gradient = const LinearGradient(colors: [
          Colors.white,
        ], stops: [
          1
        ]);
        break;
    }

    return gradient!;
  }

  WoodenFishLevelElement getLevelElementFromKnockCount(int count) {
    if (count <= 10) {
      return WoodenFishLevelElement.lv01;
    } else if (count >= 11 && count <= 20) {
      return WoodenFishLevelElement.lv04;
    } else if (count >= 21 && count <= 30) {
      return WoodenFishLevelElement.lv08;
    } else if (count >= 31 && count <= 40) {
      return WoodenFishLevelElement.lv16;
    } else {
      return WoodenFishLevelElement.lv16;
    }
  }

  WoodenFishLevelElement? getLevelElementFromString(String level) {
    for (WoodenFishLevelElement element in WoodenFishLevelElement.values) {
      if (element.toString() == level) {
        return element;
      }
    }
    return null;
  }

  String getLevelNameElementFromString(String level) {
    var levelName = '';
    for (WoodenFishLevelElement element in WoodenFishLevelElement.values) {
      if (element.toString() == level) {
        switch (element) {
          case WoodenFishLevelElement.lv01:
            levelName = '沙彌 (凡人)';
            break;
          case WoodenFishLevelElement.lv02:
            levelName = '和尚 (凡人)';
            break;
          case WoodenFishLevelElement.lv03:
            levelName = '高僧 (凡人)';
            break;
          case WoodenFishLevelElement.lv04:
            levelName = '須陀洹 (四果羅漢)';
            break;
          case WoodenFishLevelElement.lv05:
            levelName = '斯陀含 (四果羅漢)';
            break;
          case WoodenFishLevelElement.lv06:
            levelName = '阿那含 (四果羅漢)';
            break;
          case WoodenFishLevelElement.lv07:
            levelName = '阿羅漢 (四果羅漢)';
            break;

          case WoodenFishLevelElement.lv08:
            levelName = '月光菩薩 (菩薩)';
            break;
          case WoodenFishLevelElement.lv09:
            levelName = '日光菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv10:
            levelName = '大勢至菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv11:
            levelName = '靈吉菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv12:
            levelName = '地藏王菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv13:
            levelName = '文殊菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv14:
            levelName = '普賢菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv15:
            levelName = '觀音菩薩 菩薩)';
            break;
          case WoodenFishLevelElement.lv16:
            levelName = '寶蓮華善住娑羅樹王佛 (佛)';
            break;
          case WoodenFishLevelElement.lv17:
            levelName = '寶華游步佛 (佛)';
            break;
          case WoodenFishLevelElement.lv18:
            levelName = '周匝莊嚴功德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv19:
            levelName = '善游步佛 (佛)';
            break;
          case WoodenFishLevelElement.lv20:
            levelName = '紅炎幢王佛 (佛)';
            break;
          case WoodenFishLevelElement.lv21:
            levelName = '鬥戰勝佛 (佛)';
            break;
          case WoodenFishLevelElement.lv22:
            levelName = '善游步功德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv23:
            levelName = '善名稱功德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv24:
            levelName = '德念佛 (佛)';
            break;
          case WoodenFishLevelElement.lv25:
            levelName = '財功德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv26:
            levelName = '蓮華光遊戲神通佛 (佛)';
            break;
          case WoodenFishLevelElement.lv27:
            levelName = '功德華佛 (佛)';
            break;
          case WoodenFishLevelElement.lv28:
            levelName = '那羅延佛 (佛)';
            break;
          case WoodenFishLevelElement.lv29:
            levelName = '無憂德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv30:
            levelName = '光德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv31:
            levelName = '無量掬光佛 (佛)';
            break;
          case WoodenFishLevelElement.lv32:
            levelName = '旃檀功德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv33:
            levelName = '堅德佛 (佛)';
            break;
          case WoodenFishLevelElement.lv34:
            levelName = '水天佛 (佛)';
            break;
          case WoodenFishLevelElement.lv35:
            levelName = '娑留那佛 (佛)';
            break;
          case WoodenFishLevelElement.lv36:
            levelName = '清淨施佛 (佛)';
            break;
          case WoodenFishLevelElement.lv37:
            levelName = '清淨佛 (佛)';
            break;
          case WoodenFishLevelElement.lv38:
            levelName = '勇施佛 (佛)';
            break;
          case WoodenFishLevelElement.lv39:
            levelName = '離垢佛 (佛)';
            break;
          case WoodenFishLevelElement.lv40:
            levelName = '無垢佛 (佛)';
            break;
          case WoodenFishLevelElement.lv41:
            levelName = '寶月佛 (佛)';
            break;
          case WoodenFishLevelElement.lv42:
            levelName = '現無愚佛 (佛)';
            break;
          case WoodenFishLevelElement.lv43:
            levelName = '寶月光佛 (佛)';
            break;
          case WoodenFishLevelElement.lv44:
            levelName = '寶火佛 (佛)';
            break;
          case WoodenFishLevelElement.lv45:
            levelName = '精進喜佛 (佛)';
            break;
          case WoodenFishLevelElement.lv46:
            levelName = '精進軍佛 (佛)';
            break;
          case WoodenFishLevelElement.lv47:
            levelName = '龍尊王容佛 (佛)';
            break;
          case WoodenFishLevelElement.lv48:
            levelName = '寶光佛 (佛)';
            break;
          case WoodenFishLevelElement.lv49:
            levelName = '金剛不壞佛 (佛)';
            break;
          case WoodenFishLevelElement.lv50:
            levelName = '釋迦牟尼佛 (佛)';
            break;

          default:
            levelName = '小僧';
            break;
        }
      }
    }
    return levelName;
  }
}
