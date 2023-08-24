import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_state.dart';

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
  ParticleField? starField;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bgImage = WoodenFishUtil.internal()
        .getBgImageFromString(colorName: widget.state.setting.woodenFishBg);
    print(
        'widget.state.setting.woodenFishBg = ${widget.state.setting.woodenFishBg}');
    if (widget.state.setting.woodenFishBg == 'WoodenFishBgElement.bg01') {
      final SpriteSheet sparkleSpriteSheet = SpriteSheet(
        image: const AssetImage('assets/images/Ingots01.png'),
        frameWidth: 58,
      );

      // simple "star" particle field.
      starField = ParticleField(
        spriteSheet: sparkleSpriteSheet,
        // use the sprite alpha, with the particle color:
        // top left will be 0,0:
        origin: Alignment.topLeft,
        // onTick is where all the magic happens:
        onTick: (controller, elapsed, size) {
          List<Particle> particles = controller.particles;
          // add a new particle each frame:
          particles.add(Particle(
            color: Colors.white,
            // set a random x position along the width:
            x: rnd(size.width),
            vx: rnd(-5, 5),
            // set a random size:
            scale: rnd(0.5, 0),
            // show a random frame:
            frame: 0,
            // set a y velocity:
            vy: rnd(1, 8),
          ));
          // update existing particles:
          for (int i = particles.length - 1; i >= 0; i--) {
            Particle particle = particles[i];
            // call update, which automatically adds vx/vy to x/y
            particle.update();
            // remove particle if it's out of bounds:
            if (!size.contains(particle.toOffset())) particles.removeAt(i);
          }
        },
      );
    } else {
      starField = null;
    }

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
        starField != null
            ? starField!.stackBelow(child: Container())
            : const SizedBox(),
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
