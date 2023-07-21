import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_state.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

class PersonInfoSkinView extends StatelessWidget {
  const PersonInfoSkinView(
      {Key? key,
      required this.gridsElement,
      required this.state,
      required this.onTap})
      : super(key: key);

  final List<ElementModel> gridsElement;
  final PersonInfoState state;
  final Function(int elementIndex) onTap;

  @override
  Widget build(BuildContext context) {
    return (gridsElement.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisCount: 5,
                            childAspectRatio: 1.5),
                    itemCount: gridsElement?.length,
                    itemBuilder: (context, index) {
                      var image = gridsElement[index].element as Image;
                      var isSelectSkin = state.currentSkin ==
                          gridsElement[index].name as WoodenFishSkinElement;

                      return GestureDetector(
                          onTap: () {
                            onTap(index);
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 60,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5,
                                        color: isSelectSkin
                                            ? const Color(0xff37CACF)
                                            : Colors.transparent),
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: image,
                                ),
                              ),
                              isSelectSkin
                                  ? const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Color(0xff37CACF),
                                        weight: 60,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ));
                    }),
              ),
            ),
          )
        : const SizedBox();
  }
}
