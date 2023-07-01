import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showDoneAction(BuildContext context) async {
  Navigator.of(context).pop(true);
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
