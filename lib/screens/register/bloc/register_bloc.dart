import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterStarted()) {
    on<RegisterSubmmited>(_register);
  }

  final AuthRepository _authRepository;

  Future<void> _register(RegisterSubmmited event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());
    try {
      final register = Register(username: event.userName, email: event.email, password: event.password);
      await _authRepository.registerWithEmailAndPassword(register);
      emit(RegisterSucess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
