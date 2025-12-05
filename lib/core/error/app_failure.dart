// Project imports:
import 'failure.dart';

sealed class AppFailure extends Failure {
  const AppFailure(super.msg);
}

class UnexpectedFailure extends AppFailure {
  final Object error;

  UnexpectedFailure(this.error) : super(error.toString());

  @override
  String toString() => '$runtimeType(message: $message, error: $error)';
}

class UnknownFailure extends AppFailure {
  const UnknownFailure() : super('Unknown Error');
}

class MessageFailure extends AppFailure {
  const MessageFailure(super.msg);
}
