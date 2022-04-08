import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  showMaterialDialog(
      {String? title,
      String? subTitle,
      String? leftActionText,
      String? rightActionText,
      VoidCallback? leftAction,
      VoidCallback? rightAction}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title ?? ""),
            content: Text(subTitle ?? ""),
            actions: <Widget>[
              TextButton(
                  onPressed: leftAction, child: Text(leftActionText ?? "")),
              TextButton(
                onPressed: rightAction,
                child: Text(rightActionText ?? ""),
              )
            ],
          );
        });
  }

  showCustomDialog([Widget? child]) {
    print("showDialog");
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(child: child);
        });
  }

  dismissDialog() {
    Navigator.pop(context);
  }
}
