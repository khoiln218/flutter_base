// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../resources/generated/colors.gen.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: ColorName.white, child: child),
    );
  }
}
