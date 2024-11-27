import 'dart:ui';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screens/detail/movie_detail_screen.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/shared/auth/bloc/auth_bloc.dart';
import 'package:presentation/shared/image_path_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(const AuthStateLoggingOut());
        return false;
      },
      child: Scaffold(
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeSuccess) {
                return _MovieList(
                  movieList: state.movies,
                );
              } else if (state is HomeError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _MovieList extends StatefulWidget {
  const _MovieList({required this.movieList});
  final List<Movie> movieList;

  @override
  State<_MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<_MovieList> with SingleTickerProviderStateMixin {
  late final PageController _movieCardPageController;
  late final PageController _movieDetailPageController;

  int _movieCardIndex = 0;
  double _movieCardPage = 0;
  double _movieDetailsPage = 0;
  final _showMovieDetails = ValueNotifier(true);

  @override
  void initState() {
    _movieCardPageController = PageController(viewportFraction: 0.77)..addListener(_movieCardPagePercentListener);
    _movieDetailPageController = PageController()..addListener(_movieDetailsPagePercentListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;

        return Column(
          children: [
            const Spacer(),
            _moviePoster(h),
            const Spacer(),
            _movieDetail(h, w),
            const Spacer(),
          ],
        );
      },
    );
  }

  Widget _moviePoster(double h) {
    return SizedBox(
      height: h * .6,
      child: PageView.builder(
        key: const Key('movies'),
        clipBehavior: Clip.none,
        controller: _movieCardPageController,
        itemCount: widget.movieList.length,
        onPageChanged: (page) {
          _movieDetailPageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 500),
            curve: const Interval(0.25, 1, curve: Curves.decelerate),
          );
        },
        itemBuilder: (context, index) {
          final movie = widget.movieList[index];
          final progress = _movieCardPage - index;
          final isScrolling = _movieCardPageController.position.isScrollingNotifier.value;
          final isCurrentPage = index == _movieCardIndex;
          final isFirstPage = index == 0;
          final scale = lerpDouble(1, .8, progress.abs());

          return Transform.scale(
            alignment: Alignment.lerp(
              Alignment.topLeft,
              Alignment.center,
              -progress,
            ),
            scale: isScrolling && isFirstPage ? 1 - progress : scale,
            child: GestureDetector(
              onTap: () {
                _showMovieDetails.value = !_showMovieDetails.value;
                Navigator.pushNamed(
                  context,
                  MovieDetailScreen.routeName,
                  arguments: movie.id,
                );
                Future.delayed(const Duration(milliseconds: 550), () {
                  _showMovieDetails.value = !_showMovieDetails.value;
                });
              },
              child: Hero(
                key: Key(movie.id.toString()),
                tag: movie.id,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..translate(
                      isCurrentPage ? 0.0 : -20.0,
                      isCurrentPage ? 0.0 : 40.0,
                    ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(70),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25,
                        offset: const Offset(0, 25),
                        color: Colors.black.withOpacity(.2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(70),
                    child: FadeInImage.assetNetwork(
                      placeholder: kLoadingImagePlaceholder,
                      image: '$kBaseUrlForImage${movie.posterPath}',
                      imageErrorBuilder: (context, _, __) => Image.asset(
                        kNoImagePlaceHolder,
                        fit: BoxFit.fill,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _movieDetail(double h, double w) {
    return SizedBox(
      height: h * 0.25,
      child: PageView.builder(
        itemCount: widget.movieList.length,
        controller: _movieDetailPageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final movie = widget.movieList[index];
          final opacity = (index - _movieDetailsPage).clamp(0.0, 1.0);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.1),
            child: Opacity(
              opacity: 1 - opacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  ValueListenableBuilder<bool>(
                    valueListenable: _showMovieDetails,
                    builder: (_, value, child) {
                      return Visibility(
                        visible: value,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                          movie.overview,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _movieCardPagePercentListener() {
    setState(() {
      _movieCardPage = _movieCardPageController.page!;
      _movieCardIndex = _movieCardPageController.page!.round();
    });
  }

  void _movieDetailsPagePercentListener() {
    setState(() {
      _movieDetailsPage = _movieDetailPageController.page!;
    });
  }

  @override
  void dispose() {
    _movieCardPageController
      ..removeListener(_movieCardPagePercentListener)
      ..dispose();
    _movieDetailPageController
      ..removeListener(_movieDetailsPagePercentListener)
      ..dispose();
    super.dispose();
  }
}
