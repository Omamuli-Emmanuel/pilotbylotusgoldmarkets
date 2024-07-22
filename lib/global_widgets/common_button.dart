import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatefulWidget {
  const CommonButton(
      {Key? key,
        this.fillColor,
        this.borderColor,
        this.text,
        this.alignment,
        this.textColor,
        this.onPress,
        this.topPadding,
        this.bottomPadding, this.style, this.child})
      : super(key: key);

  final Color? fillColor;
  final Widget? child;
  final Color? borderColor;
  final String? text;
  final TextStyle? style;
  final TextAlign? alignment;
  final Color? textColor;
  final Function()? onPress;
  final double? topPadding;
  final double? bottomPadding;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        margin: EdgeInsets.only(
            bottom: widget.bottomPadding ?? 0, top: widget.topPadding ?? 0),
        width: width,
        height: height * 0.06,
        decoration: BoxDecoration(
            color: widget.fillColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.borderColor ?? Theme.of(context).primaryColor)),
        child: widget.child ?? Center(
            child: Text(
          widget.text ?? "",
          textAlign: widget.alignment ?? TextAlign.center,
          style: widget.style ?? GoogleFonts.lato(
            color: widget.textColor ?? Theme.of(context).scaffoldBackgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        )),
      ),
    );
  }
}
