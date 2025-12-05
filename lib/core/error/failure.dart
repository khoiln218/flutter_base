class Failure {
  final String? _message;
  const Failure(this._message);

  String get message => _message ?? '';

  @override
  String toString() => '$runtimeType(message: $message)';
}
