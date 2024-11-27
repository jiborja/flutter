abstract class TechnicalException implements Exception {
  TechnicalException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
