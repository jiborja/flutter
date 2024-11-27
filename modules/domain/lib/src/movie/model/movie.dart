import 'package:domain/src/shared/exceptions/empty_param_exception.dart';

class Movie {
  Movie({
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required double voteAverage,
    required this.adult,
  }) {
    _validateEmptyParameters();

    _voteAverage = voteAverage / 2;
  }

  final int id;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  late final double _voteAverage;
  final bool adult;

  double get voteAverage => _voteAverage;

  void _validateEmptyParameters() {
    if (title.isEmpty) throw EmptyParamException(param: 'title');

    if (originalLanguage.isEmpty) throw EmptyParamException(param: 'originalLanguage');

    if (overview.isEmpty) throw EmptyParamException(param: 'overview');

    if (posterPath.isEmpty) throw EmptyParamException(param: 'posterPath');

    if (releaseDate.isEmpty) throw EmptyParamException(param: 'releaseDate');
  }
}
