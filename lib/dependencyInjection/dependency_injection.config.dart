// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i4;
import 'package:domain/domain.module.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:infrastructure/infrastructure.module.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;
import 'package:presentation/screens/detail/bloc/movie_detail_bloc.dart' as _i7;
import 'package:presentation/screens/home/bloc/home_bloc.dart' as _i5;
import 'package:presentation/screens/login/bloc/login_bloc.dart' as _i6;
import 'package:presentation/screens/register/bloc/register_bloc.dart' as _i8;
import 'package:presentation/screens/user_detail/bloc/user_detail_bloc.dart'
    as _i9;
import 'package:presentation/shared/auth/bloc/auth_bloc.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthBloc>(
        () => _i3.AuthBloc(authRepository: gh<_i4.AuthRepository>()));
    gh.factory<_i5.HomeBloc>(() => _i5.HomeBloc(
          moviesService: gh<_i4.MoviesService>(),
          userDetailRepository: gh<_i4.UserDetailRepository>(),
        ));
    gh.factory<_i6.LoginBloc>(
        () => _i6.LoginBloc(authRepository: gh<_i4.AuthRepository>()));
    gh.factoryParam<_i7.MovieDetailBloc, int, dynamic>((
      idMovie,
      _,
    ) =>
        _i7.MovieDetailBloc(
          movieService: gh<_i4.MoviesService>(),
          idMovie: idMovie,
        ));
    gh.factory<_i8.RegisterBloc>(
        () => _i8.RegisterBloc(authRepository: gh<_i4.AuthRepository>()));
    gh.factory<_i9.UserDetailBloc>(() => _i9.UserDetailBloc(
        userDetailRepository: gh<_i4.UserDetailRepository>()));
    await _i10.InfrastructurePackageModule().init(gh);
    await _i11.DomainPackageModule().init(gh);
    return this;
  }
}
