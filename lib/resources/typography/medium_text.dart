// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../app_dimension.dart';
import 'base_text.dart';

class MediumText extends BaseText {
  MediumText(
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
    super.softWrap,
    super.textAlign,
    Paint? foreground,
    String? fontFamily,
    double? height,
  }) : super(
         style: mediumTextStyle
             .copyWith(
               color: color,
               fontSize: fontSize,
               fontWeight: fontWeight,
               letterSpacing: letterSpacing,
               wordSpacing: wordSpacing,
               decoration: decoration,
               foreground: foreground,
               fontFamily: fontFamily,
               height: height,
             )
             .merge(style),
       );

  static const TextStyle mediumTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: -0.01,
    height: 1.2,
    fontSize: AppDimension.bodyTextSize,
  );
  static const TextStyle tinySemiBoldTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: -0.01,
    height: 1.6,
    fontSize: AppDimension.tinyTextSize,
  );
}
