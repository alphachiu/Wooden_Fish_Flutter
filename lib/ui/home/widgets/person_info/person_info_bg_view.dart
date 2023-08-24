import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_state.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

class PersonInfoBgView extends StatelessWidget {
  const PersonInfoBgView(
      {Key? key,
      required this.titleName,
      required this.gridsElement,
      required this.state,
      required this.onTap,
      required this.switchOnTap})
      : super(key: key);

  final String titleName;
  final List<ElementModel> gridsElement;
  final PersonInfoState state;
  final Function(int elementIndex) onTap;
  final Function(bool) switchOnTap;

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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisCount: 5,
                            childAspectRatio: 1.5),
                    itemCount: gridsElement?.length,
                    itemBuilder: (context, index) {
                      var bgColor = gridsElement[index].element;
                      var isSelectBg =
                          state.currentBg == gridsElement[index].name;
                      var isDefault =
                          gridsElement[index].name == WoodenFishBgElement.none;

                      var bgImage = WoodenFishUtil.internal()
                          .getBgImageFromString(
                              colorName: gridsElement[index].name.toString(),
                              size: 50);

                      if (bgImage != null) {
                        return GestureDetector(
                            onTap: () {
                              onTap(index);
                            },
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5,
                                      color: isSelectBg
                                          ? const Color(0xff37CACF)
                                          : isDefault
                                              ? Colors.grey
                                              : Colors.transparent),
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 60,
                                      backgroundImage: bgImage.image,
                                    ),
                                    isSelectBg
                                        ? const Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Color(0xff37CACF),
                                              weight: 60,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                )));
                      } else {
                        return GestureDetector(
                          onTap: () {
                            onTap(index);
                          },
                          child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: isDefault ? 1 : 5,
                                    color: isSelectBg
                                        ? const Color(0xff37CACF)
                                        : isDefault
                                            ? Colors.grey
                                            : Colors.transparent),
                                shape: BoxShape.circle,
                                color: bgColor,
                              ),
                              child: Stack(
                                children: [
                                  isDefault
                                      ? const Center(
                                          child: Text('預設',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue)),
                                        )
                                      : const SizedBox(),
                                  isSelectBg
                                      ? const Center(
                                          child: Icon(
                                            Icons.check,
                                            color: Color(0xff37CACF),
                                            weight: 60,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              )),
                        );
                      }
                    }),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        titleName,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Switch.adaptive(
                          activeColor: const Color(0xff37CACF),
                          value: state.setting.isSetPrayPhoto,
                          onChanged: (isChange) {
                            switchOnTap(isChange);
                          })
                    ],
                  ),
                )),
          );
    ;
  }
}
