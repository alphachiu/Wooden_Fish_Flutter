import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_state.dart';
import 'dart:ui' as ui;
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

class CustomBgMain extends StatefulWidget {
  const CustomBgMain({
    super.key,
    required this.state,
    this.prayPhotoOnTap,
  });

  final WoodFishWidgetState state;
  final Function()? prayPhotoOnTap;

  @override
  State<CustomBgMain> createState() => _CustomBgMainState();
}

class _CustomBgMainState extends State<CustomBgMain>
    with TickerProviderStateMixin {
  Image? bgImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bgImage = WoodenFishUtil.internal()
        .getBgImageFromString(colorName: widget.state.setting.woodenFishBg);

    var size = 0.0;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      size = MediaQuery.of(context).size.width * 0.1;
    } else {
      size = MediaQuery.of(context).size.height * 0.15;
    }
    return Stack(
      children: [
        Container(
            color: widget.state.bgColor,
            width: double.infinity,
            height: double.infinity,
            child: bgImage),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            widget.state.setting.isSetPrayPhoto
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: widget.prayPhotoOnTap,
                        child: SizedBox(
                          height: size,
                          width: size,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: widget.state.prayPhoto.image,
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox()
          ],
        )
      ],
    );
  }
}
