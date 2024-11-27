class InvalidUsernameException implements Exception {
  InvalidUsernameException({this.message = _invalidUserNameException});

  static const _invalidUserNameException = 'Please enter a valid user name';

  final String message;

  @override
  String toString() {
    return message;
  }
}
