// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../app_dimension.dart';
import 'base_text.dart';

class SemiBoldText extends BaseText {
  SemiBoldText(
    super.data, {
    super.key,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    TextStyle? style,
    super.maxLines,
    super.textOverflow,
    super.textAlign,
  }) : super(
         style: semiBoldTextStyle
             .copyWith(
               color: color,
               fontSize: fontSize,
               fontWeight: fontWeight,
               letterSpacing: letterSpacing,
               wordSpacing: wordSpacing,
               decoration: decoration,
             )
             .merge(style),
       );

  static const TextStyle semiBoldTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01,
    height: 1.2,
    fontSize: AppDimension.bodyTextSize,
  );

  static const TextStyle tinySemiBoldTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    height: 1.6,
    fontSize: AppDimension.tinyTextSize,
  );
}
