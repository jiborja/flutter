import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';

class MockMoviesService extends Mock implements MoviesService {}

class MockUserDetailRepository extends Mock implements UserDetailRepository {}
class MockNetworkVerify extends Mock implements NetworkVerify {}

void main() {
  late UserDetail userDetail;
  late MoviesService moviesService;
  late UserDetailRepository userDetailRepository;
  late HomeBloc homeBloc;
  late NetworkVerify networkVerify;
  setUp(() {
    userDetail = UserDetail(age: 20);
    registerFallbackValue(userDetail);
    moviesService = MockMoviesService();
    userDetailRepository = MockUserDetailRepository();
    networkVerify = MockNetworkVerify();
    homeBloc = HomeBloc(
      moviesService: moviesService,
      userDetailRepository: userDetailRepository,
    );
  });

  group('HomeBloc', () {
    blocTest<HomeBloc, HomeState>(
      '> get movies request > emit HomeSuccess state with empty response',
      //Arrange
      build: () => homeBloc,
      setUp: () {
        when(() => moviesService.getMovies(any())).thenAnswer((_) async => []);
        when(() => userDetailRepository.getAge()).thenAnswer((_) async => userDetail.age);
      },
      //act
      act: (bloc) => bloc.add(GetMovies()),
      //Assert
      expect: () => <HomeState>[HomeLoading(), const HomeSuccess(movies: [])],
    );
  });

  blocTest<HomeBloc, HomeState>(
      '> get movies request with error response > emit HomeError NotConnectedToNetworkException state',
      //Arrange
      build: () => homeBloc,
      setUp: () {
        when(() => moviesService.getMovies(any())).thenThrow((_) => NotConnectedToNetworkException());
        when(() => userDetailRepository.getAge()).thenAnswer((_) async => userDetail.age);
        when(() => networkVerify.isConnected).thenAnswer((_) async => false);
      },
      //act
      act: (bloc) => bloc.add(GetMovies()),
      //Assert
      expect: () => [isA<HomeLoading>(), isA<HomeError>()],
    );

    blocTest<HomeBloc, HomeState>(
      '> get movies request with error response > emit HomeError state',
      //Arrange
      build: () => homeBloc,
      setUp: () {
        when(() => moviesService.getMovies(any())).thenThrow((_)  => Exception());
        when(() => userDetailRepository.getAge()).thenAnswer((_) async => userDetail.age);
      },
      //act
      act: (bloc) => bloc.add(GetMovies()),
      //Assert
      expect: () => [isA<HomeLoading>(), isA<HomeError>()],
    );
}
