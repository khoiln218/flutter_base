// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../app_dimension.dart';
import 'base_text.dart';

class BoldText extends BaseText {
  BoldText(
    super.data, {
    super.key,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    TextStyle? style,
    List<Shadow>? shadows,
    String? fontFamily,
    super.maxLines,
    super.textOverflow,
    super.textAlign,
    super.softWrap,
    double? height,
  }) : super(
         style: boldTextStyle
             .copyWith(
               color: color,
               fontSize: fontSize,
               fontWeight: fontWeight,
               letterSpacing: letterSpacing,
               wordSpacing: wordSpacing,
               decoration: decoration,
               shadows: shadows,
               fontFamily: fontFamily,
               height: height,
             )
             .merge(style),
       );

  static const TextStyle boldTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    letterSpacing: -0.01,
    height: 1.2,
    fontSize: AppDimension.bodyTextSize,
  );

  static const TextStyle smallBoldTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    letterSpacing: -0.01,
    height: 1.2,
    fontSize: AppDimension.smallTextSize,
  );

  static const TextStyle tinyBoldTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    letterSpacing: -0.01,
    height: 1.6,
    fontSize: AppDimension.tinyTextSize,
  );
}
