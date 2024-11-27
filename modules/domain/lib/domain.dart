library domain;

import 'package:injectable/injectable.dart';

export 'package:domain/src/analytics/model/event.dart' show Event;
export 'package:domain/src/analytics/repositories/analytics_repository.dart' show AnalyticsRepository;
export 'package:domain/src/auth/model/login.dart' show Login;
export 'package:domain/src/auth/model/register.dart' show Register;
export 'package:domain/src/auth/model/user.dart' show User;
export 'package:domain/src/auth/repositories/auth_repository.dart' show AuthRepository;
export 'package:domain/src/movie/exceptions/invalid_id_exception.dart' show InvalidIdException;
export 'package:domain/src/movie/exceptions/movie_exception.dart' show MovieException;
export 'package:domain/src/movie/exceptions/no_data_movie_exception.dart' show NoDataMovieException;
export 'package:domain/src/movie/model/movie.dart' show Movie;
export 'package:domain/src/movie/repositories/movie_repository.dart' show MovieRepository;
export 'package:domain/src/movie/services/movies_service.dart' show MoviesService;
export 'package:domain/src/user_detail/model/user_detail.dart' show UserDetail;
export 'package:domain/src/user_detail/repositories/user_detail_repository.dart' show UserDetailRepository;

@InjectableInit.microPackage()
void initDomain() {}
