import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/shared/auth/bloc/auth_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

class MockGlobalKey extends Mock implements GlobalKey<NavigatorState> {}

class MockNavigatorState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

void main() {
  late AuthRepository mockAuthRepository;
  late User mockUser;
  late GlobalKey<NavigatorState> mockGlobalKey;
  late NavigatorState mockNavigatorState;
  late AuthBloc authBloc;

  setUp(() {
    mockGlobalKey = MockGlobalKey();
    mockAuthRepository = MockAuthRepository();
    mockNavigatorState = MockNavigatorState();
    mockUser = MockUser();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  group('AuthStream', () {
    blocTest<AuthBloc, AuthState>(
      '> listening login request > emit AuthLoggedIn state after listening to the auth stream',
      // Arrange
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthRepository.authState).thenAnswer((_) {
          return Stream.fromIterable([mockUser]);
        });
        when(() => mockGlobalKey.currentState).thenReturn(mockNavigatorState);
        when(() => mockNavigatorState.pushNamed(any())).thenAnswer((_) async => null);
      },
      // Act
      act: (bloc) => bloc.add(AuthStateInitialized(navigatorKey: mockGlobalKey)),
      // Assert
      expect: () => [isA<AuthLoggedIn>()],
    );

    blocTest<AuthBloc, AuthState>(
      '> listening logout request > emit AuthLoggedOut after listening auth stream with no user',
      // Arrange
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthRepository.authState).thenAnswer((_) {
          return Stream.fromIterable([null]);
        });
        when(() => mockGlobalKey.currentState).thenReturn(mockNavigatorState);
        when(() => mockNavigatorState.popUntil(any())).thenAnswer((_) async => {});
      },
      // Act
      act: (bloc) => bloc.add(AuthStateInitialized(navigatorKey: mockGlobalKey)),
      // Assert
      expect: () => [isA<AuthLoggedOut>()],
    );

    blocTest<AuthBloc, AuthState>(
      '> listening AuthLoggedIn and AuthStateLogOut states in the auth stream with a user > then no user',
      // Arrange
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthRepository.authState).thenAnswer((_) {
          return Stream.fromIterable([mockUser, null]);
        });
        when(() => mockGlobalKey.currentState).thenReturn(mockNavigatorState);
        when(() => mockNavigatorState.pushNamed(any())).thenAnswer((_) async => null);
        when(() => mockNavigatorState.popUntil(any())).thenAnswer((_) async => {});
      },
      // Act
      act: (bloc) => bloc.add(AuthStateInitialized(navigatorKey: mockGlobalKey)),
      // Assert
      expect: () => [isA<AuthLoggedIn>(), isA<AuthLoggedOut>()],
    );
  });

  group('Logout', () {
    blocTest<AuthBloc, AuthState>(
      '> logout request > not emits state after AuthStateLogingOut event',
      // Arrange
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthRepository.logOut()).thenAnswer((_) async {});
      },
      // Act
      act: (bloc) => bloc.add(const AuthStateLoggingOut()),
      // Assert
      expect: () => <TypeMatcher<AuthState>>[],
    );

    blocTest<AuthBloc, AuthState>(
      '> logout request with error > emits AuthError state',
      // Arrange
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthRepository.logOut()).thenThrow(Exception('login-error'));
      },
      // Act
      act: (bloc) => bloc.add(const AuthStateLoggingOut()),
      // Assert
      expect: () => [isA<AuthError>()],
    );
  });
}
