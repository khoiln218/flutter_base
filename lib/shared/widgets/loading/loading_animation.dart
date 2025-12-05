// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:lottie/lottie.dart';

// Project imports:
import '../../../core/utils/mixin/lifecycle_logger.dart';
import '../../../resources/generated/assets.gen.dart';

// Project imports:

class LoadingAnimation extends StatefulWidget {
  final double? width;
  final double? height;
  const LoadingAnimation({super.key, this.width = 100, this.height = 100});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with StatefulLifecycleLogger, SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.forward(from: 0.5).whenComplete(() {
      _controller.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Assets.raw.loadingAnimation.path,
        controller: _controller,
        height: widget.width,
        width: widget.height,
        fit: BoxFit.scaleDown,
        onLoaded: (composition) {
          _controller.duration = composition.duration;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
