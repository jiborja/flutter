import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/detail/bloc/movie_detail_bloc.dart';
import 'package:presentation/shared/image_path_constants.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});
  static const routeName = 'movie-detail-screen';

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailSuccess) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              return Scaffold(
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _movieImage(h, w, state.movie!),
                    _movieDetailBody(h, w, context, state.movie!),
                    _buttonBack(h, w, context),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buttonBack(double h, double w, BuildContext context) {
    return Positioned(
      bottom: h * .9,
      right: w * .85,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  Widget _movieImage(double h, double w, Movie movie) {
    return Positioned(
      top: h * -.1,
      width: w,
      height: h * .6,
      child: Hero(
        tag: movie.id,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(70)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 20,
                offset: const Offset(0, 20),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: FadeInImage.assetNetwork(
              placeholder: kLoadingImagePlaceholder,
              image: '$kBaseUrlForImage${movie.posterPath}',
              imageErrorBuilder: (context, _, __) => Image.asset(
                kNoImagePlaceHolder,
                fit: BoxFit.contain,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _movieStars(double numberOfStars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < numberOfStars; i++)
          const Icon(
            Icons.star,
            color: Colors.amber,
          )
      ],
    );
  }

  Widget _informationMovie(String value, String content) {
    return ColoredBox(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _movieDetailBody(
    double h,
    double w,
    BuildContext context,
    Movie movie,
  ) {
    return Positioned(
      height: h * .5,
      width: w,
      child: Column(
        children: [
          const Spacer(),
          Hero(
            tag: movie.title,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                movie.title.toUpperCase(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          _movieStars(movie.voteAverage),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * .1),
            child: Text(
              movie.overview,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _informationMovie(
                AppLocalizations.of(context).movie_detail_screen_original_language,
                movie.originalLanguage,
              ),
              _informationMovie(
                AppLocalizations.of(context).movie_detail_screen_release_date,
                movie.releaseDate,
              )
            ],
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
