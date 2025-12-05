// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'generated/assets.gen.dart';

enum Flavor { dev, stg, prod }

extension FlavorX on Flavor {
  String get name {
    switch (this) {
      case Flavor.dev:
        return "dev";
      case Flavor.stg:
        return "stg";
      case Flavor.prod:
        return "prod";
    }
  }

  String get filename {
    switch (this) {
      case Flavor.dev:
        return Assets.env.develop;
      case Flavor.stg:
        return Assets.env.staging;
      case Flavor.prod:
        return Assets.env.production;
    }
  }
}

class Environment {
  final String baseUrl;
  final Flavor flavor;

  Environment({required this.baseUrl, required this.flavor});
}

class AppConfig {
  static Environment load(Flavor flavor) {
    return Environment(baseUrl: dotenv.get('BASE_URL'), flavor: flavor);
  }
}
