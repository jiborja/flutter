import 'package:http/http.dart';
import 'package:infrastructure/src/shared/http_client/exceptions/http_client_exception.dart';
import 'package:injectable/injectable.dart';

@injectable
class HttpClient {
  HttpClient() {
    _client = Client();
    _timeOut = const Duration(seconds: _maxSecondsToWaitResponse);
  }

  late final Client _client;
  late final Duration _timeOut;

  static const _maxSecondsToWaitResponse = 10;
  static const _httpStatusCodeOk = 200;

  Future<String> getRequest(Uri url) async {
    Response response;
    try {
      response = await _client.get(url).timeout(_timeOut);
    } finally {
      _client.close();
    }
    return response.statusCode == _httpStatusCodeOk
        ? response.body
        : throw HttpClientException();
  }
}
