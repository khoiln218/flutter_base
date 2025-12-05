// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import '../generated/colors.gen.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    this.initialValue,
    this.labelText,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.inputFormatters,
    this.textStyle,
    this.readOnly = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.autofillHints,
    this.autocorrect,
    this.contentPadding,
    this.disable = false,
    this.focusNode,
    this.hintText,
    this.hintStyle,
    this.markRequired,
    this.helpText,
    this.helpStyle,
    this.textCapitalization = TextCapitalization.none,
    this.inputBorder,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.controller,
    this.decoration,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.enableInteractiveSelection = true,
    this.onSubmitted,
    this.fill = false,
    this.fillColor = Colors.white,
    this.enable = true,
    this.expands = false,
    this.canRequestFocus = true,
  });
  final bool readOnly;
  final String? initialValue;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final int? maxLength;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final bool disable;
  final FocusNode? focusNode;
  final String? hintText;
  final bool? markRequired;
  final TextStyle? hintStyle;
  final String? helpText;
  final TextStyle? helpStyle;
  final TextCapitalization textCapitalization;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<String>? autofillHints;
  final bool? autocorrect;
  final InputBorder? inputBorder;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final int? minLines;
  final int? maxLines;
  final bool obscureText;
  final TextAlign textAlign;
  final bool enableInteractiveSelection;
  final ValueChanged<String>? onSubmitted;
  final bool fill;
  final Color fillColor;
  final bool enable;
  final bool expands;
  final bool canRequestFocus;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      enabled: enable,
      expands: expands,
      onTap: onTap,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      style: disable
          ? textStyle?.copyWith(color: ColorName.hintTextColor)
          : textStyle,
      readOnly: readOnly,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
      autofillHints: readOnly ? null : autofillHints,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText,
      textAlign: textAlign,
      enableInteractiveSelection: enableInteractiveSelection,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration:
          decoration ??
          InputDecoration(
            contentPadding: contentPadding,
            floatingLabelBehavior: floatingLabelBehavior,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle,
            helperStyle: helpStyle,
            helperText: helpText,
            border: inputBorder,
            enabledBorder: inputBorder,
            disabledBorder: inputBorder,
            enabled: enable,
            fillColor: fillColor,
            filled: fill,
            helperMaxLines: 2,
            focusedBorder: inputBorder?.copyWith(
              borderSide: const BorderSide(
                color: ColorName.darkWhite,
                width: 1.5,
              ),
            ),
          ),
    );
  }
}
