import 'package:flutter/material.dart';

void makeRoutePage({BuildContext context, Widget pageRef}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageRef),
      (Route<dynamic> route) => false);
}
