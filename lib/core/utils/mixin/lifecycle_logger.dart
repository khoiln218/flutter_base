// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import '../logger/logger_service_impl.dart';

/// StatefulWidget version
mixin StatefulLifecycleLogger<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    _log('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _log('didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    _log('didUpdateWidget');
  }

  @override
  void dispose() {
    _log('dispose');
    super.dispose();
  }

  void _log(String method) {
    logger.w(
      '${widget.runtimeType} -> $method',
      showMethod: false,
      showFile: false,
    );
  }
}
