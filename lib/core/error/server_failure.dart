// Project imports:
import 'failure.dart';

sealed class NetworkFailure extends Failure {
  const NetworkFailure(super.msg);
}

class ServerFailure extends NetworkFailure {
  final int? code;
  final dynamic response;

  const ServerFailure(super.msg, {this.code, this.response});

  @override
  String toString() =>
      '$runtimeType(code: $code, message: $message, response: $response)';
}
