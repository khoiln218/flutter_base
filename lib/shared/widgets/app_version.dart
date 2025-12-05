// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import '../../resources/all.dart';
import '../../resources/app_config.dart';
import '../../resources/generated/colors.gen.dart';
import '../../resources/typography/all.dart';
import '../injection.dart';

class AppVersion extends StatelessWidget {
  final bool isDark;
  const AppVersion({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return _buildAppVersion();
  }

  Widget _buildAppVersion() {
    return FutureBuilder(
      future: getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RegularText(
            snapshot.data!,
            color: isDark ? ColorName.white : ColorName.black,
            fontSize: AppDimension.smallTextSize,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    final suffix = switch (sl<Environment>().flavor) {
      Flavor.prod => '',
      Flavor.stg => '-stg',
      Flavor.dev => '-dev',
    };
    return 'V$version$suffix+$buildNumber';
  }
}
