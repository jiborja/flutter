import 'package:infrastructure/src/movie/http_client/dto/dates.dart';
import 'package:infrastructure/src/movie/http_client/dto/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movies.g.dart';

@JsonSerializable()
class Movies {
  Movies({
    this.dates,
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);

  Dates? dates;
  int? page;
  late List<Movie> results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}
