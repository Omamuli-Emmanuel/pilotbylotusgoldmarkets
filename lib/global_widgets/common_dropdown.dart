import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonDropdownField<T> extends StatefulWidget {
  const CommonDropdownField({
    Key? key,
    this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.icon,
    this.label,
    this.enabled = true,
    this.topPadding,
    this.bottomPadding,
  }) : super(key: key);

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final IconData? icon;
  final String? label;
  final bool enabled;
  final double? topPadding;
  final double? bottomPadding;

  @override
  State<CommonDropdownField<T>> createState() => _CommonDropdownFieldState<T>();
}

class _CommonDropdownFieldState<T> extends State<CommonDropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (widget.label != null)
          Row(
            children: [
              SizedBox(width: w * 0.01),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.label!,
                  style: GoogleFonts.urbanist(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        DropdownButtonFormField<T>(
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
          hint: Text(
            widget.hintText,
            style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 16),
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 0.50, color: Color(0xFFD9D9D9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.50, color: Color(0xFFD9D9D9)),
            ),
            suffixIcon: (widget.icon != null)
                ? Icon(
                    widget.icon,
                    color: Colors.grey.withOpacity(0.8),
                    size: 30,
                  )
                : const SizedBox.shrink(),
          ),
          style: GoogleFonts.lato(
            color: const Color(0xFFC0C0C0),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          icon: const SizedBox.shrink(),
          dropdownColor: Colors.white,
        ),
      ],
    );
  }
}
