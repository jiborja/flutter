class NotDataFoundException implements Exception {
  NotDataFoundException({this.message = _noDataFound});
  final String message;
  static const _noDataFound = 'No data found';

  @override
  String toString() {
    return message;
  }
}
