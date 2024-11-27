//@GeneratedMicroModule;InfrastructurePackageModule;package:infrastructure/infrastructure.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:domain/domain.dart' as _i20;
import 'package:firebase_analytics/firebase_analytics.dart' as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:infrastructure/infrastructure.dart' as _i24;
import 'package:infrastructure/module_register.dart' as _i28;
import 'package:infrastructure/src/analytics/analytics_module.dart' as _i29;
import 'package:infrastructure/src/analytics/reporitories/analytics_firebase_repository.dart'
    as _i22;
import 'package:infrastructure/src/auth/repositories/auth_firebase_repository.dart'
    as _i23;
import 'package:infrastructure/src/movie/persistence/dao/movie_dao.dart'
    as _i25;
import 'package:infrastructure/src/movie/repositories/contracts/movie_local_repository.dart'
    as _i8;
import 'package:infrastructure/src/movie/repositories/contracts/movie_remote_repository.dart'
    as _i10;
import 'package:infrastructure/src/movie/repositories/contracts/movie_temporal_repository.dart'
    as _i13;
import 'package:infrastructure/src/movie/repositories/development/movie_shared_preferences_repository_in_memory.dart'
    as _i14;
import 'package:infrastructure/src/movie/repositories/development/movies_drift_repository_in_memory.dart'
    as _i9;
import 'package:infrastructure/src/movie/repositories/development/movies_http_repository_dev.dart'
    as _i11;
import 'package:infrastructure/src/movie/repositories/movie_proxy.dart' as _i27;
import 'package:infrastructure/src/movie/repositories/production/movie_shared_preferences_repository.dart'
    as _i15;
import 'package:infrastructure/src/movie/repositories/production/movies_drift_repository.dart'
    as _i26;
import 'package:infrastructure/src/movie/repositories/production/movies_http_repository.dart'
    as _i12;
import 'package:infrastructure/src/shared/http_client/http_client.dart' as _i6;
import 'package:infrastructure/src/shared/network/network_module.dart' as _i30;
import 'package:infrastructure/src/shared/network/network_verify.dart' as _i17;
import 'package:infrastructure/src/shared/persistence/movies_database.dart'
    as _i16;
import 'package:infrastructure/src/shared/secure_storage/secure_repository.dart'
    as _i18;
import 'package:infrastructure/src/shared/secure_storage/secure_storage_repository.dart'
    as _i19;
import 'package:infrastructure/src/user_detail/repositories/user_detail_shared_preferences_repository.dart'
    as _i21;
import 'package:injectable/injectable.dart' as _i1;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;

const String _dev = 'dev';
const String _prod = 'prod';

class InfrastructurePackageModule extends _i1.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i2.FutureOr<void> init(_i1.GetItHelper gh) {
    final analyticsModule = _$AnalyticsModule();
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i3.FirebaseAnalytics>(
        () => analyticsModule.firebaseAnalytics());
    gh.factory<_i4.FirebaseAuth>(() => registerModule.firebaseAuth());
    gh.factory<_i5.FlutterSecureStorage>(() => registerModule.secureStorage());
    gh.factory<_i6.HttpClient>(() => _i6.HttpClient());
    gh.lazySingleton<_i7.InternetConnectionChecker>(
        () => networkModule.internetConnectionChecker());
    gh.singleton<_i8.MovieLocalRepository>(
      _i9.MoviesDriftRepositoryInMemory(),
      registerFor: {_dev},
    );
    gh.singleton<_i10.MovieRemoteRepository>(
      _i11.MoviesHttpRepositoryDev(),
      registerFor: {_dev},
    );
    gh.singleton<_i10.MovieRemoteRepository>(
      _i12.MoviesHttpRepository(gh<_i6.HttpClient>()),
      registerFor: {_prod},
    );
    gh.singleton<_i13.MovieTemporalRepository>(
      _i14.MovieSharedPreferencesRepositoryInMemory(),
      registerFor: {_dev},
    );
    gh.factory<_i13.MovieTemporalRepository>(
      () => _i15.MovieSharedPreferencesRepository(),
      registerFor: {_prod},
    );
    gh.singleton<_i16.MoviesDatabase>(_i16.MoviesDatabase());
    gh.lazySingleton<_i17.NetworkVerify>(
        () => _i17.NetworkVerify(gh<_i7.InternetConnectionChecker>()));
    gh.factory<_i18.SecureRepository>(() =>
        _i19.SecureStorageRepository(storage: gh<_i5.FlutterSecureStorage>()));
    gh.factory<_i20.UserDetailRepository>(
        () => _i21.AgeSharedPreferencesRepository());
    gh.factory<_i20.AnalyticsRepository>(() => _i22.AnalyticsFirebaseRepository(
        firebaseAnalytics: gh<_i3.FirebaseAnalytics>()));
    gh.factory<_i20.AuthRepository>(() => _i23.AuthFirebaseRepository(
          firebaseAuth: gh<_i4.FirebaseAuth>(),
          secureRepository: gh<_i18.SecureRepository>(),
          networkVerify: gh<_i24.NetworkVerify>(),
        ));
    gh.factory<_i25.MovieDao>(() => _i25.MovieDao(gh<_i16.MoviesDatabase>()));
    gh.factory<_i8.MovieLocalRepository>(
      () => _i26.MoviesDriftRepository(gh<_i25.MovieDao>()),
      registerFor: {_prod},
    );
    gh.factory<_i20.MovieRepository>(() => _i27.MovieProxy(
          movieLocalRepository: gh<_i8.MovieLocalRepository>(),
          remoteRepository: gh<_i10.MovieRemoteRepository>(),
          temporalRepository: gh<_i13.MovieTemporalRepository>(),
          analyticsRepository: gh<_i20.AnalyticsRepository>(),
          networkVerify: gh<_i24.NetworkVerify>(),
        ));
  }
}

class _$RegisterModule extends _i28.RegisterModule {}

class _$AnalyticsModule extends _i29.AnalyticsModule {}

class _$NetworkModule extends _i30.NetworkModule {}
