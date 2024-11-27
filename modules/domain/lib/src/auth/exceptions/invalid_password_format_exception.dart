class InvalidPasswordFormatException implements Exception {
  InvalidPasswordFormatException({
    this.message = _invalidPasswordFormatException,
  });

  static const _invalidPasswordFormatException = 'Password does not meet the minimum security requirements';

  final String message;

  @override
  String toString() {
    return message;
  }
}
