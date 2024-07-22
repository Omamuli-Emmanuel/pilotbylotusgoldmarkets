import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {

  const CommonTextField(
      {Key? key,
      this.controller,
      this.icon,
      required this.hintText,
      this.inputType,
      this.showText = true,
      this.topPadding,
      this.bottomPadding,
      this.suffixIcon,
      this.label,
      this.enabled = true,
      this.onTap,
      this.inputFormatters,
      this.node,
      this.fillColor,
      this.hintStyle,
      this.maxLine,
      this.borderColor,
      this.leftTextPad,
      this.topTextPad,
      this.onSubmitted,
      this.onChanged, this.labelStyle, this.suffixSVG, this.prefixSVG, this.decoration})
      : super(key: key);

  final TextEditingController? controller;
  final IconData? icon;
  final String hintText;
  final TextInputType? inputType;
  final bool showText;
  final String? label;
  final int? maxLine;
  final Color? fillColor, borderColor;
  final bool enabled;
  final InputDecoration? decoration;
  final double? topPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final double? bottomPadding;
  final IconData? suffixIcon;
  final Widget? suffixSVG;
  final Widget? prefixSVG;
  final Function()? onTap;
  final FocusNode? node;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final double? leftTextPad, topTextPad;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.topPadding ?? 0, bottom: widget.bottomPadding ?? 0),
      child: Column(
        children: [
          // if(widget.label != null)Row(
          //   children: [
          //     SizedBox(width: w*0.01,),
          //     Container(
          //       margin: const EdgeInsets.only(bottom: 10),
          //       child: Text(widget.label!, style: GoogleFonts.urbanist(
          //         color: Theme.of(context).textTheme.bodyMedium?.color,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,),),
          //     ),
          //   ],
          // ),
          TextField(
            showCursor: true,
            textAlign: TextAlign.left,
            enabled: widget.enabled,
            obscureText: !widget.showText,
            keyboardType: widget.inputType,
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            focusNode: widget.node,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLine,
            decoration: InputDecoration(
                filled: true,
                label: widget.label == null ? null : Text(
                  widget.label!,
                  style: widget.labelStyle,
                ),
                fillColor: widget.fillColor ?? Colors.grey,
                contentPadding: EdgeInsets.only(
                    left: widget.leftTextPad ?? 20,
                    top: widget.topTextPad ?? 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 0.50,
                      color: widget.borderColor ?? const Color(0xFFD9D9D9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.8, color: Colors.blue),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.8, color: Color(0xFFA4A4A4)),
                ),
                prefixIcon: widget.prefixSVG ?? ((widget.icon != null)
                    ? Icon(
                        widget.icon,
                        color: Colors.white70,
                        size: 20,
                      )
                    : null),
                suffixIcon: widget.suffixSVG ?? ((widget.suffixIcon != null)
                    ? IconButton(
                        icon: Icon(widget.suffixIcon),
                        onPressed: widget.onTap,
                      )
                    : null),
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    TextStyle(
                        color: Colors.grey.withOpacity(
                          0.6,
                        ),
                        fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
