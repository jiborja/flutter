class InvalidEmailException implements Exception {
  InvalidEmailException({this.message = _invalidEmailException});

  static const _invalidEmailException = 'Please enter a valid email';

  final String message;

  @override
  String toString() {
    return message;
  }
}
