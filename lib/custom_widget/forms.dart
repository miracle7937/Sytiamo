import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sytiamo/utils/colors.dart';

class SYForm extends StatefulWidget {
  final String labelText, hintText, suffixText;
  final bool forPassword, enable;
  final EdgeInsetsGeometry padding;
  final Color fillColor,
      inputTextColor,
      focusedBorderColor,
      enabledBorderColor,
      disabledBorderColor,
      labelColor,
      border;
  final EdgeInsetsGeometry contentPadding;
  final Widget suffixIcon, suffixWidget;
  final Function(String) onChange;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextStyle hintStyle;

  const SYForm(
      {Key key,
      this.enable = true,
      this.labelText,
      this.hintText,
      this.forPassword = false,
      this.padding,
      this.fillColor,
      this.contentPadding,
      this.onChange,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.controller,
      this.inputTextColor,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.labelColor,
      this.hintStyle,
      this.disabledBorderColor,
      this.suffixText,
      this.border,
      this.suffixWidget})
      : super(key: key);

  @override
  _SYFormState createState() => _SYFormState();
}

class _SYFormState extends State<SYForm> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            vertical: 10,
          ),
      child: Container(
        height: 49,
        child: TextFormField(
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          enabled: widget.enable,
          onChanged: widget.onChange,
          cursorColor: mainColor,
          obscureText: widget.forPassword && showPassword,
          style: TextStyle(
              color: widget.inputTextColor ?? whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              suffixIcon: widget.suffixWidget,
              suffixText: widget.suffixText,
              contentPadding: widget.contentPadding ?? EdgeInsets.all(8),
              fillColor: widget.fillColor,
              filled: true,
              suffix: widget.forPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: showPassword
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                              size: 15,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 15,
                            ))
                  : (widget.suffixIcon),
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: TextStyle(color: widget.labelColor ?? whiteColor),
              hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.disabledBorderColor ?? greyColor)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.enabledBorderColor ?? Color(0xffbfc9da))),
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.focusedBorderColor ?? mainColor))),
        ),
      ),
    );
  }
}

class SYDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final Function(T) onChange;
  final T value;
  final Widget hint;
  final String hintDescription;

  const SYDropDown(
      {Key key,
      @required this.onChange,
      @required this.items,
      this.value,
      this.hintDescription,
      this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hintDescription != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  hintDescription,
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 49,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: greyColor),
              color: whiteColor,
              borderRadius: BorderRadius.circular(5)),

          // dropdown below..
          child: Center(
            child: DropdownButton<T>(
                isExpanded: true,
                value: value,
                hint: hint,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 22,
                underline: SizedBox(),
                onChanged: (v) => onChange(v),
                items: items),
          ),
        ),
      ],
    );
  }
}

class CXDropDownWithImage<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final Function(T) onChange;
  final T value;

  const CXDropDownWithImage({Key key, this.items, this.onChange, this.value})
      : super(key: key);

  @override
  _CXDropDownWithImageState createState() => _CXDropDownWithImageState();
}

class _CXDropDownWithImageState extends State<CXDropDownWithImage> {
  var selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          color: whiteColor,
          borderRadius: BorderRadius.circular(5)),

      // dropdown below..
      child: Center(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 22,
          underline: SizedBox(),
          onChanged: widget.onChange,
          items: widget.items,
        ),
      ),
    );
  }
}

class SYTitleForm extends StatefulWidget {
  final String labelText, hintText, suffixText, setValue;
  final TextStyle hintStyle;
  final bool forPassword, enable;
  final EdgeInsetsGeometry padding;
  final Color fillColor, inputTextColor;
  final EdgeInsetsGeometry contentPadding;
  final Icon suffixIcon;
  final Function(String) onChange;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String conversionText, title;
  final Color focusedBorderColor, enabledBorderColor, disabledBorderColor;
  final int maxLines;
  final double formHeight;

  const SYTitleForm(
      {Key key,
      this.hintStyle,
      this.enable = true,
      this.labelText,
      this.hintText,
      this.forPassword = false,
      this.padding,
      this.fillColor,
      this.contentPadding,
      this.onChange,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.controller,
      this.inputTextColor,
      this.suffixText,
      this.conversionText,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.disabledBorderColor,
      this.title,
      this.setValue,
      this.maxLines,
      this.formHeight})
      : super(key: key);

  @override
  _CXTitleFormState createState() => _CXTitleFormState();
}

class _CXTitleFormState extends State<SYTitleForm> {
  bool showPassword = true;
  TextEditingController controller;
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            vertical: 10,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? "",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: widget.formHeight ?? 49,
            child: TextFormField(
              maxLines: widget.maxLines ?? 1,
              initialValue: widget.setValue,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              enabled: widget.enable,
              onChanged: widget.onChange,
              cursorColor: mainColor,
              obscureText: widget.forPassword,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  suffixText: widget.suffixText,
                  contentPadding: EdgeInsets.all(8),
                  // fillColor: widget.fillColor,
                  // filled: true,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  labelStyle: TextStyle(color: whiteColor),
                  hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.disabledBorderColor ?? greyColor)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              widget.enabledBorderColor ?? Color(0xffbfc9da))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: greyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.focusedBorderColor ?? mainColor))),
            ),
          ),
        ],
      ),
    );
  }
}

class CXDateForm extends StatefulWidget {
  final String labelText, hintText, suffixText, setValue;
  final bool forPassword, enable, changeFormat;
  final EdgeInsetsGeometry padding;
  final Color fillColor, inputTextColor;
  final EdgeInsetsGeometry contentPadding;
  final Icon suffixIcon;
  final Function(String) onChange;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String conversionText, title;
  final Color focusedBorderColor, enabledBorderColor, disabledBorderColor;

  const CXDateForm(
      {Key key,
      this.enable = true,
      this.labelText,
      this.hintText,
      this.forPassword = false,
      this.padding,
      this.fillColor,
      this.contentPadding,
      this.onChange,
      this.suffixIcon,
      this.inputFormatters,
      this.keyboardType,
      this.controller,
      this.inputTextColor,
      this.suffixText,
      this.conversionText,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.disabledBorderColor,
      this.title,
      this.setValue,
      this.changeFormat = true})
      : super(key: key);

  @override
  _CXDateFormState createState() => _CXDateFormState();
}

class _CXDateFormState extends State<CXDateForm> {
  bool showPassword = true;
  final _controller = TextEditingController();

  @override
  void dispose() {
    // other dispose methods
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleText);
    // other code here
  }

  _handleText() {
    // do what you want with the text, for example:
    _controller.text = widget.setValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime date = DateTime(1900);
        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now());

        // = date.toIso8601String();
        _controller.text =
            DateFormat(widget.changeFormat ? 'dd/MM/yyyy' : "yyyy-MM-dd")
                .format(date);

        widget.onChange(_controller.text);
      },
      child: Padding(
        padding: widget.padding ??
            const EdgeInsets.symmetric(
              vertical: 10,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? "",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 49,
              child: TextFormField(
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                controller: widget.controller ?? _controller,
                enabled: false,
                onChanged: widget.onChange,
                cursorColor: mainColor,
                obscureText: widget.forPassword,
                style: TextStyle(
                    color: widget.inputTextColor ?? Colors.black, fontSize: 12),
                decoration: InputDecoration(
                    suffixText: widget.suffixText,
                    contentPadding: widget.contentPadding,
                    fillColor: widget.fillColor,
                    // filled: true,
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    labelStyle: TextStyle(color: whiteColor),
                    hintStyle: TextStyle(color: Colors.grey),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.disabledBorderColor ?? greyColor)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.enabledBorderColor ?? greyColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.focusedBorderColor ?? mainColor))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
