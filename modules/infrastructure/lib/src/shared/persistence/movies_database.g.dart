// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_database.dart';

// ignore_for_file: type=lint
class $MovieEntityTable extends MovieEntity
    with TableInfo<$MovieEntityTable, MovieEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
      'original_language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult =
      GeneratedColumn<bool>('adult', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("adult" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        originalLanguage,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        adult
      ];
  @override
  String get aliasedName => _alias ?? 'movie_entity';
  @override
  String get actualTableName => 'movie_entity';
  @override
  VerificationContext validateIntegrity(Insertable<MovieEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language']!, _originalLanguageMeta));
    } else if (isInserting) {
      context.missing(_originalLanguageMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    } else if (isInserting) {
      context.missing(_posterPathMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('adult')) {
      context.handle(
          _adultMeta, adult.isAcceptableOrUnknown(data['adult']!, _adultMeta));
    } else if (isInserting) {
      context.missing(_adultMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      originalLanguage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_language'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview'])!,
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      adult: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}adult'])!,
    );
  }

  @override
  $MovieEntityTable createAlias(String alias) {
    return $MovieEntityTable(attachedDatabase, alias);
  }
}

class MovieEntityData extends DataClass implements Insertable<MovieEntityData> {
  final int id;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final bool adult;
  const MovieEntityData(
      {required this.id,
      required this.originalLanguage,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.adult});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['original_language'] = Variable<String>(originalLanguage);
    map['overview'] = Variable<String>(overview);
    map['poster_path'] = Variable<String>(posterPath);
    map['release_date'] = Variable<String>(releaseDate);
    map['title'] = Variable<String>(title);
    map['vote_average'] = Variable<double>(voteAverage);
    map['adult'] = Variable<bool>(adult);
    return map;
  }

  MovieEntityCompanion toCompanion(bool nullToAbsent) {
    return MovieEntityCompanion(
      id: Value(id),
      originalLanguage: Value(originalLanguage),
      overview: Value(overview),
      posterPath: Value(posterPath),
      releaseDate: Value(releaseDate),
      title: Value(title),
      voteAverage: Value(voteAverage),
      adult: Value(adult),
    );
  }

  factory MovieEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieEntityData(
      id: serializer.fromJson<int>(json['id']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      overview: serializer.fromJson<String>(json['overview']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      title: serializer.fromJson<String>(json['title']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      adult: serializer.fromJson<bool>(json['adult']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'overview': serializer.toJson<String>(overview),
      'posterPath': serializer.toJson<String>(posterPath),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'title': serializer.toJson<String>(title),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'adult': serializer.toJson<bool>(adult),
    };
  }

  MovieEntityData copyWith(
          {int? id,
          String? originalLanguage,
          String? overview,
          String? posterPath,
          String? releaseDate,
          String? title,
          double? voteAverage,
          bool? adult}) =>
      MovieEntityData(
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        voteAverage: voteAverage ?? this.voteAverage,
        adult: adult ?? this.adult,
      );
  @override
  String toString() {
    return (StringBuffer('MovieEntityData(')
          ..write('id: $id, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('adult: $adult')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, originalLanguage, overview, posterPath,
      releaseDate, title, voteAverage, adult);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieEntityData &&
          other.id == this.id &&
          other.originalLanguage == this.originalLanguage &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.title == this.title &&
          other.voteAverage == this.voteAverage &&
          other.adult == this.adult);
}

class MovieEntityCompanion extends UpdateCompanion<MovieEntityData> {
  final Value<int> id;
  final Value<String> originalLanguage;
  final Value<String> overview;
  final Value<String> posterPath;
  final Value<String> releaseDate;
  final Value<String> title;
  final Value<double> voteAverage;
  final Value<bool> adult;
  const MovieEntityCompanion({
    this.id = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.adult = const Value.absent(),
  });
  MovieEntityCompanion.insert({
    this.id = const Value.absent(),
    required String originalLanguage,
    required String overview,
    required String posterPath,
    required String releaseDate,
    required String title,
    required double voteAverage,
    required bool adult,
  })  : originalLanguage = Value(originalLanguage),
        overview = Value(overview),
        posterPath = Value(posterPath),
        releaseDate = Value(releaseDate),
        title = Value(title),
        voteAverage = Value(voteAverage),
        adult = Value(adult);
  static Insertable<MovieEntityData> custom({
    Expression<int>? id,
    Expression<String>? originalLanguage,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<String>? title,
    Expression<double>? voteAverage,
    Expression<bool>? adult,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (title != null) 'title': title,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (adult != null) 'adult': adult,
    });
  }

  MovieEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? originalLanguage,
      Value<String>? overview,
      Value<String>? posterPath,
      Value<String>? releaseDate,
      Value<String>? title,
      Value<double>? voteAverage,
      Value<bool>? adult}) {
    return MovieEntityCompanion(
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      adult: adult ?? this.adult,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieEntityCompanion(')
          ..write('id: $id, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('adult: $adult')
          ..write(')'))
        .toString();
  }
}

abstract class _$MoviesDatabase extends GeneratedDatabase {
  _$MoviesDatabase(QueryExecutor e) : super(e);
  late final $MovieEntityTable movieEntity = $MovieEntityTable(this);
  late final MovieDao movieDao = MovieDao(this as MoviesDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieEntity];
}
