import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  Movie({
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.adult,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  final int id;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final String title;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  final bool adult;

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  String toString() {
    return title;
  }
}
