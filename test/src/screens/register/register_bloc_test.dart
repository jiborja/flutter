import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/register/bloc/register_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  late RegisterBloc registerBloc;

  late Register register;

  setUp(() {
    register = Register(username: 'username', email: 'email@email.com', password: 'Password78#');
    registerFallbackValue(register);
    authRepository = MockAuthRepository();
    registerBloc = RegisterBloc(authRepository: authRepository);
  });

  group('RegisterBloc', () {
    blocTest<RegisterBloc, RegisterState>(
      '> register request with invalid email > emit RegisterError state',
      //Arrange
      build: () => registerBloc,
      setUp: () {
        when(() => authRepository.registerWithEmailAndPassword(any())).thenAnswer((_) async {});
      },
      //Act
      act: (bloc) => bloc.add(RegisterSubmmited('not-mail-format', register.password, register.username)),
      //Assert
      expect: () => [isA<RegisterInProgress>(), isA<RegisterError>()],
    );

    blocTest<RegisterBloc, RegisterState>(
      '> register request with invalid password format > emit RegisterError state',
      //Arrange
      build: () => registerBloc,
      setUp: () {
        when(() => authRepository.registerWithEmailAndPassword(any())).thenAnswer((_) async {});
      },
      //Act
      act: (bloc) => bloc.add(RegisterSubmmited(register.email, 'weak', register.username)),
      //Assert
      expect: () => [isA<RegisterInProgress>(), isA<RegisterError>()],
    );

    blocTest<RegisterBloc, RegisterState>(
      '> register request with invalid username format > emit RegisterError state',
      //Arrange
      build: () => registerBloc,
      setUp: () {
        when(() => authRepository.registerWithEmailAndPassword(any())).thenAnswer((_) async {});
      },
      //Act
      act: (bloc) => bloc.add(RegisterSubmmited(register.email, register.password, 'a b c')),
      //Assert
      expect: () => [isA<RegisterInProgress>(), isA<RegisterError>()],
    );

    blocTest<RegisterBloc, RegisterState>(
      '> register request with valid data > emit RegisterSucess state',
      //Arrange
      build: () => registerBloc,
      setUp: () {
        when(() => authRepository.registerWithEmailAndPassword(any())).thenAnswer((_) async {});
      },
      //Act
      act: (bloc) => bloc.add(RegisterSubmmited(register.email, register.password, register.username)),
      //Assert
      expect: () => <RegisterState>[RegisterInProgress(), RegisterSucess()],
    );
  });
}
