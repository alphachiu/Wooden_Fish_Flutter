import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_state.dart';

class PersonInfoSoundView extends StatelessWidget {
  const PersonInfoSoundView(
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 20, top: 10, bottom: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisCount: 5,
                            childAspectRatio: 1),
                    itemCount: gridsElement?.length,
                    itemBuilder: (context, index) {
                      var isSelectSound = state.currentSound ==
                          gridsElement[index].name as WoodenFishSoundElement;

                      return GestureDetector(
                          onTap: () {
                            onTap(index);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5,
                                        color: isSelectSound
                                            ? const Color(0xff37CACF)
                                            : Colors.transparent),
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: Stack(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 60,
                                        child: Icon(
                                          Icons.music_note,
                                          size: 30,
                                        ),
                                      ),
                                      isSelectSound
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
                              SizedBox(
                                height: 10,
                              ),
                              Text('${index + 1}'),
                            ],
                          ));
                    }),
              ),
            ),
          )
        : const SizedBox();
  }
}
