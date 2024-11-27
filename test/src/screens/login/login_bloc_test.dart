import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';

import '../../shared/builder/login_builder.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late LoginBloc loginBloc;
  late Login login;

  setUp(() {
    login = LoginBuilder().build();
    registerFallbackValue(login);
    authRepository = MockAuthRepository();
    loginBloc = LoginBloc(authRepository: authRepository);
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      '> login request with valid data > emit LoginSuccess state',
      // Arrange
      build: () => loginBloc,
      setUp: () {
        when(() => authRepository.logInWithEmailAndPassword(any())).thenAnswer((_) async {});
      },
      // Assert
      act: (bloc) => bloc.add(LogIn(email: login.email, password: login.password)),
      // Assert
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );

    blocTest<LoginBloc, LoginState>(
      '> login request with invalid data > emit LoginError state',
      // Arrange
      build: () => loginBloc,
      setUp: () {
        when(() => authRepository.logInWithEmailAndPassword(any())).thenThrow(Exception('login-error'));
      },
      // Assert
      act: (bloc) => bloc.add(const LogIn(email: 'not-an-email', password: 'mypassword')),
      // Assert
      expect: () => [isA<LoginLoading>(), isA<LoginError>()],
    );
  });
}
