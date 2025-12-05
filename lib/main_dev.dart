// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'main.dart' as common;
import 'resources/app_config.dart';
import 'shared/injection.dart' as di;

void main() async {
  final flavor = Flavor.dev;
  await dotenv.load(fileName: flavor.filename);
  await di.init(flavor: flavor);
  common.main();
}
