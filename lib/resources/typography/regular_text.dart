// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../app_dimension.dart';
import 'base_text.dart';

class RegularText extends BaseText {
  RegularText(
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
    super.softWrap,
    double? height,
  }) : super(
         style: regularTextStyle
             .copyWith(
               color: color,
               fontSize: fontSize,
               fontWeight: fontWeight,
               letterSpacing: letterSpacing,
               wordSpacing: wordSpacing,
               decoration: decoration,
               height: height,
             )
             .merge(style),
       );

  static const TextStyle regularTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    height: 1.2,
    fontSize: AppDimension.bodyTextSize,
  );

  static const TextStyle smallRegularTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    height: 1.2,
    fontSize: AppDimension.smallTextSize,
  );

  static const TextStyle tinyRegularTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    height: 1.6,
    fontSize: AppDimension.tinyTextSize,
  );
}
