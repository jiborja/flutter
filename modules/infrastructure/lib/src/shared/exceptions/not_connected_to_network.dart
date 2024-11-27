class NotConnectedToNetworkException implements Exception {
  NotConnectedToNetworkException({this.message = _notConnectedToNetwork});
  final String message;
  static const _notConnectedToNetwork = 'Not connected to network';

  @override
  String toString() {
    return message;
  }
}
