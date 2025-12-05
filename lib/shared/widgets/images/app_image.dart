// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'network_image.dart';

class AppImage extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget Function(BuildContext context)? placeHolder;
  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    if (path?.isNotEmpty == true) {
      return path?.startsWith('http') == true
          ? AppNetworkImage(
              image: path!,
              height: height,
              width: width,
              fit: fit,
              placeHolder: placeHolder,
            )
          : path?.endsWith('.svg') == true
          ? SvgPicture.asset(
              path!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            )
          : path?.startsWith('assets') == true
          ? Image.asset(path!, height: height, width: width, fit: fit)
          : Image.file(File(path!), height: height, width: width, fit: fit);
    }
    return const SizedBox.shrink();
  }
}
