import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      this.controller,
      this.icon,
      this.formatters,
      required this.hintText,
      this.inputType,
      this.showText = true,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.suffixIcon,
      this.onTap,
      this.enabled = true,
      this.showLabel = true,
      this.label,
      this.validator,
      this.suffixWidget,
      this.prefixWidget,
      this.node,
      this.onSubmitted,
      this.leftTextPad,
      this.topTextPad,
      this.inputFormatters,
      this.maxLine,
      this.fillColor,
      this.borderColor,
      this.hintStyle,
      this.onChanged,
      this.labelStyle,
      this.onClick,
      this.readOnly,
      })
      : super(key: key);

  final TextEditingController? controller;
  final IconData? icon;
  final String hintText;
  final TextStyle? hintStyle;
  final Function()? onTap;
  final Function()? onClick;
  final TextInputType? inputType;
  final bool showText;
  final bool? enabled, readOnly;
  final double? topPadding;
  final double? bottomPadding;
  final IconData? suffixIcon;
  final TextStyle? labelStyle;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final int? maxLine;
  final Color? fillColor, borderColor;
  final bool showLabel;
  final String? label;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validator;
  final FocusNode? node;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final double? leftTextPad, topTextPad;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
          //       child: Text(widget.label!, style: TextStyle(
          //         color: Theme.of(context).textTheme.bodyMedium?.color,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,),),
          //     ),
          //   ],
          // ),
          TextFormField(
            showCursor: true,
            textAlign: TextAlign.left,
            enabled: widget.enabled,
            obscureText: !widget.showText,
            keyboardType: widget.inputType,
            controller: widget.controller,
            onFieldSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            focusNode: widget.node,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLine ?? 1,
            onTap: widget.onClick,
            readOnly: widget.readOnly ?? false,
            decoration: InputDecoration(
                filled: true,
                label: widget.label == null
                    ? null
                    : Text(
                        widget.label!,
                        style: widget.labelStyle,
                      ),
                fillColor: widget.fillColor ?? Colors.white,
                contentPadding: EdgeInsets.only(
                    left: widget.leftTextPad ?? 20,
                    top: widget.topTextPad ?? 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 0.50,
                      color: widget.borderColor ?? Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0.8, color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.8, color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0.8, color: Color(0xFFA4A4A4)),
                ),
                prefixIcon: (widget.icon != null)
                    ? Icon(
                        widget.icon,
                        color: Colors.white70,
                        size: 20,
                      )
                    : null,
                suffixIcon: widget.suffixWidget ??
                    ((widget.suffixIcon != null)
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
