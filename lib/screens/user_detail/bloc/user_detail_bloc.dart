import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

@injectable
class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc({required UserDetailRepository userDetailRepository})
      : _userDetailRepository = userDetailRepository,
        super(UserDetailStarted()) {
    on<UserDetailSubmited>((event, emit) async {
      try {
        emit(UserDetailInProccess());

        final userDetail = UserDetail(age: event.age);

        await _userDetailRepository.saveAge(userDetail.age);
        emit(UserDetailSuccess());
      } catch (e) {
        emit(UserDetailError(e.toString()));
      }
    });
  }

  final UserDetailRepository _userDetailRepository;
}
