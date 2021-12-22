import 'package:flutter/material.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/images.dart';

void showErrorSnackbar(String text,
    {BuildContext context,
    GlobalKey<ScaffoldState> key,
    SnackBarAction action}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    duration: Duration(milliseconds: 1700),
    backgroundColor: Colors.red,
    action: action,
  );
  if (key != null) {
    key.currentState.showSnackBar(snackBar);
  } else {
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

Future<void> showSnackbar(String text, BuildContext context,
    {GlobalKey<ScaffoldState> key,
    SnackBarAction action,
    Color textColor,
    Color backgroundColor,
    hide = true,
    Duration duration}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Container(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Spacer(),
        InkWell(
            onTap: () => key.currentState.hideCurrentSnackBar(),
            child: Image.asset(SYImages.closeIcon)),
        SizedBox(
          width: 10,
        )
      ],
    ),
    duration: duration ?? Duration(milliseconds: 2000),
    backgroundColor: mainColor,
    action: action,
  );
  if (key != null) {
    key.currentState.showSnackBar(snackBar);
  } else {
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

void showInSnackBar(context, {String value, Color color}) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    duration: Duration(milliseconds: 20000),
    backgroundColor: mainColor,
    content: Row(
      children: [
        Container(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Spacer(),
        InkWell(
            onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
            child: Image.asset(SYImages.closeIcon)),
        SizedBox(
          width: 10,
        )
      ],
    ),
  ));
}
