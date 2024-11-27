import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitialized()) {
    on<LogIn>(_logIn);
  }

  final AuthRepository _authRepository;

  Future<void> _logIn(LogIn event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _authRepository.logInWithEmailAndPassword(Login(email: event.email, password: event.password));
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
