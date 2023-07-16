
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:woodenfish_bloc/ui/custom_bg/custom_bg_paint/custom_bg_paint.dart';
import 'dart:ui' as ui;

class CustomBgMain extends StatefulWidget {
  const CustomBgMain({super.key});

  @override
  State<CustomBgMain> createState() => _CustomBgMainState();
}


class _CustomBgMainState extends State<CustomBgMain> with TickerProviderStateMixin{

  late Ticker ticker;
  final notifier = ValueNotifier(Duration.zero);
  ui.Image? sprite ;

  @override
  void initState() {
    super.initState();
    ticker = Ticker(_tick);
    getUiImage('assets/images/Ingots01.png', 40, 40).then((image) {
      setState(() {
        print("image = $image");
        sprite = image;
        ticker.start();
      });
    });

    // rootBundle.load('assets/images/Ingots01.png')
    //     .then((data) => decodeImageFromList(data.buffer.asUint8List()))
    //     .then(_setSprite);
  }

  _tick(Duration d) => notifier.value = d;

  Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      assetImageByteData.buffer.asUint8List(),
      targetHeight: height,
      targetWidth: width,
    );
    var image = (await codec.getNextFrame()).image;
      return image;

  }

  // _setSprite(ui.Image image) {
  //   setState(() {
  //      print('image: $image');
  //
  //     sprite = image;
  //     ticker.start();
  //   });
  // }


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: double.infinity,

      child: Stack(
        children: [
          //第一部分 背景
          // Positioned.fill(
          //   child: Image.asset(
          //     "assets/images/bg_snow.png",
          //     fit: BoxFit.fill,
          //   ),
          // ),
          CustomPaint(
            size: MediaQuery.of(context).size,
            foregroundPainter: FallingBirdsPainter(objectImage: sprite, notifier: notifier),
            child: const Center(
              child: SizedBox(),
            ),
          )
        ],
      ),
    );

  }
}
