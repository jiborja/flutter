import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required MoviesService moviesService,
    required UserDetailRepository userDetailRepository,
  })  : _moviesService = moviesService,
        _userDetailRepository = userDetailRepository,
        super(HomeLoading()) {
    on<GetMovies>((event, emit) async {
      emit(HomeLoading());
      try {
        final userAge = await _userDetailRepository.getAge();
        final result = await _moviesService.getMovies(UserDetail(age: userAge));
        emit(HomeSuccess(movies: result));
      } on MovieException catch (e) {
        emit(HomeError(e.toString()));
      } on NotConnectedToNetworkException catch (e) {
        emit(HomeError(e.toString()));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }

  final MoviesService _moviesService;
  final UserDetailRepository _userDetailRepository;
  @override
  Future<void> close() {
    debugPrint('HomeBloc - close $_moviesService');
    return super.close();
  }
}
