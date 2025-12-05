// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String image;
  final String? hash;
  final BoxFit? fit;
  final Alignment? alignment;
  final int? cacheWidth;
  final int? cacheHeight;
  final Color? color;
  final BlendMode? colorBlendMode;
  final Widget Function(BuildContext context)? placeHolder;
  const AppNetworkImage({
    super.key,
    this.width,
    this.height,
    required this.image,
    this.alignment,
    this.hash,
    this.fit,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.colorBlendMode,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: OctoImage(
        color: color,
        image: CachedNetworkImageProvider(image),
        alignment: alignment,
        placeholderBuilder:
            placeHolder ??
            (context) => ShimmerImage(height: height, width: width),
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
        width: width,
        height: height,
        colorBlendMode: colorBlendMode,
        errorBuilder: OctoError.icon(color: Colors.red),
        fit: fit ?? BoxFit.scaleDown,
      ),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  final double? width;
  final double? height;
  const ShimmerImage({super.key, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 222, 222, 222),
        highlightColor: const Color.fromARGB(255, 237, 237, 237),
        child: SizedBox(width: width, height: height),
      ),
    );
  }
}
