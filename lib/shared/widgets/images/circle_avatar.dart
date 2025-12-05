// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import '../../../resources/app_dimension.dart';
import 'app_image.dart';

class CachedCircleAvatar extends StatelessWidget {
  const CachedCircleAvatar({
    super.key,
    required this.url,
    this.size = AppDimension.kAppBarAvatarSize,
  });
  final String url;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      width: size,
      height: size,
      child: AppImage(path: url, fit: BoxFit.cover),
    );
  }
}
