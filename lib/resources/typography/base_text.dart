// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../app_dimension.dart';
import '../generated/fonts.gen.dart';

class BaseText extends Text {
  BaseText(
    super.data, {
    super.key,
    TextStyle? style,
    super.maxLines,
    TextOverflow? textOverflow,
    super.textAlign,
    super.softWrap,
    super.textScaleFactor,
    super.locale,
    super.strutStyle,
  }) : super(
         style: baseTextStyle.merge(style),
         overflow: textOverflow ?? TextOverflow.ellipsis,
       );

  static const TextStyle baseTextStyle = TextStyle(
    color: Colors.black,
    fontSize: AppDimension.bodyTextSize,
    fontFamily: FontFamily.pretendard,
  );
}
