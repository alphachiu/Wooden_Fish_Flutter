import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/levelInfo_view.dart';

import '../ui/home/widgets/setting_widget/bloc/setting_state.dart';

Future<void> showDoneAction(BuildContext context) async {
  Navigator.of(context).pop(true);
}

void showLevelLine(BuildContext context, SettingWidgetState state) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          //contentPadding: const EdgeInsets.all(30),
          content: Container(
            color: Colors.transparent,
            child: Stack(children: [
              LevelInfoView(
                state: state,
              ),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop();
                    state.isDisplayLevelList = false;
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ]),
          ),
        );
      });
}

void showSupport(BuildContext context) {
  showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
            backgroundColor: Colors.transparent,
            //contentPadding: const EdgeInsets.all(30),
            content: SizedBox(
              width: 400,
              height: 400,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Image(
                      image: AssetImage('assets/images/feedback.png'),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          )),
                      Flexible(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: screenWidth * 0.1,
                                            right: screenWidth * 0.1,
                                            top: 30),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            ChromeSafariBrowser().open(
                                                url: Uri.parse(
                                                    'https://forms.gle/Drw49AZhoNdr3ESu8'),
                                                options: ChromeSafariBrowserClassOptions(
                                                    android: AndroidChromeCustomTabsOptions(
                                                        shareState:
                                                            CustomTabsShareState
                                                                .SHARE_STATE_OFF),
                                                    ios: IOSSafariOptions(
                                                        presentationStyle:
                                                            IOSUIModalPresentationStyle
                                                                .OVER_FULL_SCREEN,
                                                        barCollapsingEnabled:
                                                            true)));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              primary: Colors.white),
                                          child: const Text(
                                            "給予建議",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.1,
                                          right: screenWidth * 0.1,
                                          bottom: 10,
                                          top: 15),
                                      child: const Text(
                                        "抖內支持：",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    print('copy');
                                    await Clipboard.setData(const ClipboardData(
                                            text:
                                                "0x8e587f3ef3adc0659850bbf1cd2e0bb971eadebb"))
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("地址已複製"),
                                        ),
                                      );
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenWidth * 0.1,
                                            right: 10,
                                            bottom: 10),
                                        child: const Text(
                                          "USDT(BEP-20)：",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.white,
                                        child: const Icon(Icons.copy),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ));
      });
}

Future<void> showTFDialog(
  BuildContext context, {
  required TextEditingController controller,
  String title = "",
  required String content,
  String cancelActionText = "取消",
  String defaultActionText = "完成",
  Function(String word)? doneActon,
  Function? cancelActon,
  bool isWillPop = true,
}) {
  if (!Platform.isIOS) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        autofocus: true,
                        controller: controller,
                        decoration: InputDecoration(hintText: content),
                      ))
                    ],
                  ),
                ],
              )),
          actions: <Widget>[
            if (cancelActionText != "")
              ElevatedButton(
                child: Text(cancelActionText),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  print('cancelActon = ${cancelActon}');
                  if (cancelActon != null) {
                    cancelActon();
                  }
                },
              ),
            ElevatedButton(
              child: Text(defaultActionText),
              onPressed: doneActon != null
                  ? () async {
                      cancelActionText == ""
                          ? doneActon("")
                          : showDoneAction(context).then((value) {
                              if (controller.text.isEmpty) {
                                doneActon("");
                              } else {}
                            });
                    }
                  : () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }

  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: content),
                  ))
                ],
              ),
            ],
          )),
      actions: <Widget>[
        if (cancelActionText != "")
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (cancelActon != null) {
                cancelActon();
              }
            },
          ),
        CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: doneActon != null
                ? () async {
                    showDoneAction(context).then((value) {
                      doneActon(controller.text);
                    });
                  }
                : () => Navigator.of(context).pop(true)),
      ],
    ),
  );
}

Future<void> showAlertDialog(
  BuildContext context, {
  String title = "",
  required String content,
  String cancelActionText = "Cancel",
  String defaultActionText = "OK",
  Function? doneActon,
  Function? cancelActon,
  bool isWillPop = true,
}) {
  if (!Platform.isIOS) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title == "" ? "提醒" : title),
          content: Text(
            content,
            // style: TextStyle(fontSize: 25),
          ),
          actions: <Widget>[
            if (cancelActionText != "")
              ElevatedButton(
                child: Text(cancelActionText),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  print('cancelActon = ${cancelActon}');
                  if (cancelActon != null) {
                    cancelActon();
                  }
                },
              ),
            ElevatedButton(
              child: Text(defaultActionText),
              onPressed: doneActon != null
                  ? () async {
                      cancelActionText == ""
                          ? !isWillPop
                              ? doneActon()
                              : showDoneAction(context).then((value) {
                                  doneActon();
                                })
                          : isWillPop
                              ? showDoneAction(context).then((value) {
                                  doneActon();
                                })
                              : doneActon();
                    }
                  : () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }
  print('cancelActionText = ${cancelActionText}');
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title == "" ? "提醒" : title),
      content: Text(
        content,
        style: TextStyle(fontSize: 15),
      ),
      actions: <Widget>[
        if (cancelActionText != "")
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () {
              Navigator.of(context).pop(false);
              print('cancelActon = ${cancelActon}');
              if (cancelActon != null) {
                print('cancelActon 2= ${cancelActon}');
                cancelActon();
              }
            },
          ),
        CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: doneActon != null
                ? () async {
                    cancelActionText == ""
                        ? !isWillPop
                            ? doneActon()
                            : showDoneAction(context).then((value) {
                                doneActon();
                              })
                        : isWillPop
                            ? showDoneAction(context).then((value) {
                                doneActon();
                              })
                            : doneActon();
                  }
                : () => Navigator.of(context).pop(true)),
      ],
    ),
  );
}
