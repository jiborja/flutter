class OutOfRangeAgeException implements Exception {
  OutOfRangeAgeException({this.message = _outOfRangeAgeException});

  static const _outOfRangeAgeException = 'Your age is out of range';
  final String message;

  @override
  String toString() {
    return message;
  }
}
