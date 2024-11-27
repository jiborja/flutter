import 'package:domain/domain.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_local_repository.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_remote_repository.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_temporal_repository.dart';
import 'package:infrastructure/src/shared/network/network_verify.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MovieRepository)
class MovieProxy implements MovieRepository {
  MovieProxy({
    required MovieLocalRepository movieLocalRepository,
    required MovieRemoteRepository remoteRepository,
    required MovieTemporalRepository temporalRepository,
    required AnalyticsRepository analyticsRepository,
    required NetworkVerify networkVerify,
  })  : _movieLocalRepository = movieLocalRepository,
        _movieRemoteRepository = remoteRepository,
        _temporalRepository = temporalRepository,
        _analyticsRepository = analyticsRepository,
        _networkVerify = networkVerify;

  final NetworkVerify _networkVerify;
  final MovieLocalRepository _movieLocalRepository;
  final MovieRemoteRepository _movieRemoteRepository;
  final MovieTemporalRepository _temporalRepository;
  final AnalyticsRepository _analyticsRepository;
  static const _millisPerDay = 3600000;

  @override
  Future<Movie?> getMovie(int id) async {
    final result = await _movieLocalRepository.getMovie(id);
    if (result != null) {
      await _analyticsRepository.registerEvent(
        Event(name: 'movie_selected', data: result.title),
      );
    }
    return result;
  }

  @override
  Future<List<Movie>> getMovies() async {
    final sharedTime = await _temporalRepository.getLastUpdatedPreference();
    final isEmptyLocal = await _movieLocalRepository.isEmpty();
    if (!isEmptyLocal && _isUpdated(sharedTime)) {
      return _movieLocalRepository.getMovies();
    } else {
      if (await _networkVerify.isConnected) {
        final response = await _movieRemoteRepository.getMovies();
        await _insertMovies(response);
        return response;
      } else {
        throw NotConnectedToNetworkException();
      }
    }
  }

  Future<void> _insertMovies(List<Movie> movies) async {
    await _movieLocalRepository.insertMovies(movies);
    await _temporalRepository.saveLastUpdatedPreference(
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  bool _isUpdated(String storeDate) {
    final actualDate = DateTime.now().millisecondsSinceEpoch;
    if (storeDate.isNotEmpty) {
      return (actualDate - int.parse(storeDate)) <= _millisPerDay;
    } else {
      return false;
    }
  }
}
