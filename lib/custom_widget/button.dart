import 'package:flutter/material.dart';
import 'package:sytiamo/utils/colors.dart';

class SYButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final bool loading;
  final Color color, borderColor, disabledColor;
  final TextStyle textStyle;
  final bool disAble;
  final Widget child;

  const SYButton({
    Key key,
    @required this.title,
    this.callback,
    this.loading = false,
    this.disAble = false,
    this.color,
    this.textStyle,
    this.borderColor,
    this.disabledColor,
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: color ?? mainColor,
      onTap: (loading || disAble) ? null : callback,
      child: Container(
        height: 49,
        decoration: (loading || disAble)
            ? BoxDecoration(
                color: disabledColor ?? Colors.black.withOpacity(0.2),
                border:
                    Border.all(color: borderColor ?? Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(5))
            : BoxDecoration(
                color: color == null ? mainColor : color,
                border: Border.all(
                    color: borderColor ?? Colors.transparent, width: 0.9),
                borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: !loading
              ? (child ??
                  Text(title,
                      style: textStyle == null
                          ? TextStyle(fontSize: 16, color: whiteColor)
                          : textStyle))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.black87)),
                ),
        ),
      ),
    );
  }
}
