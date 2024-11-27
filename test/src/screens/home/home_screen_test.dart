import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/screens/home/home_screen.dart';

import '../detail/builder/movie_data_builder.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  late TestWidgetsFlutterBinding binding;
  late HomeBloc bloc;
  late Size defaultScreenSize;
  late List<Movie> movies;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
    defaultScreenSize = const Size(1080, 1920);
    bloc = MockHomeBloc();
    movies = MovieBuilder().buildMovieList(10);
  });
  group('HomeScreen', () {
    testWidgets(' > load home page > show one movie poster at least', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(defaultScreenSize);
      when(() => bloc.state).thenReturn(HomeSuccess(movies: movies));

      //Act
      await tester.pumpWidget(
        BlocProvider<HomeBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: HomeScreen(),
            ),
            supportedLocales: [Locale('en')],
          ),
        ),
      );

      await tester.pumpAndSettle();

      //Arrange
      expect(find.byKey(const Key('1')), findsOneWidget);
      expect(find.byKey(Key((movies.length + 10).toString())), findsNothing);
      //expect(find.text('MOVIE'), findsWidgets);
    });
  });
}
