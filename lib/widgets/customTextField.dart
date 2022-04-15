import 'package:flutter/material.dart';
import 'package:recipes/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final double? size;
  final String hintText;
  final onChanged;
  final TextInputType? inputType;
  final inputFormatter;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final bool readOnly;
  final bool obscureText;
  final Color? fillColor;
  final bool filled;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? textColor;
  final textCapitalization;
  final FontWeight? weight;
  final double? borderRadius;

  CustomTextField({
    this.size,
    required this.hintText,
    required this.onChanged,
    this.onPressed,
    this.inputType,
    this.inputFormatter,
    this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.fillColor,
    this.filled = true,
    this.icon,
    this.textColor,
    this.textCapitalization,
    this.weight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      autofocus: autoFocus,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      keyboardType: inputType,
      inputFormatters: inputFormatter,
      textCapitalization: textCapitalization != null
          ? textCapitalization
          : TextCapitalization.sentences,
      textAlign: TextAlign.start,
      maxLength: maxLength,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Saira',
        fontSize: size,
        color: textColor == null ? Colors.white : textColor,
        fontWeight: weight
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 3)),
        labelText: hintText,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            height: 2, color: textColor == null ? Colors.white : textColor),
        filled: filled,
        fillColor: filled ? fillColor : primaryColor,
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 30, color: textColor),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Saira',
        ),
      ),
    );
  }
}
