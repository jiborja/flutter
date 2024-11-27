class EmptyParamException implements Exception {
  EmptyParamException({required String param}) {
    message = '$param cannot be empty.';
  }

  late final String message;

  @override
  String toString() {
    return message;
  }
}
