class InvalidAgeException implements Exception {
  InvalidAgeException({this.message = _invalidAgeException});

  static const _invalidAgeException = 'Please enter a valid age';

  final String message;

  @override
  String toString() {
    return message;
  }
}
