import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:infrastructure/src/movie/anticorruption/movie_translator.dart';
import 'package:infrastructure/src/movie/http_client/dto/movies.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_remote_repository.dart';
import 'package:infrastructure/src/shared/http_client/http_client.dart';
import 'package:injectable/injectable.dart';

const _authority = 'api.themoviedb.org';
const _unencodedPath = '/3/movie/upcoming';
const _apiKey = '4005b57c0bfee0310d6958d0c8683128';

@Singleton(as: MovieRemoteRepository, env: [Environment.prod])
class MoviesHttpRepository implements MovieRemoteRepository {
  MoviesHttpRepository(this.httpClient);
  final HttpClient httpClient;

  static const _apiKeyParamName = 'api_key';

  @override
  Future<List<Movie>> getMovies() async {
    final queryParams = <String, dynamic>{_apiKeyParamName: _apiKey};
    final uri = Uri.https(_authority, _unencodedPath, queryParams);

    final response = await httpClient.getRequest(uri);
    final data = Movies.fromJson(jsonDecode(response) as Map<String, dynamic>);
    return data.results.map(MovieTranslator.fromDtoToDomain).toList();
  }
}
