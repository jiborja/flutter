import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/login_screen.dart';

import 'page_object/login_page_object.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  late LoginBloc bloc;
  late Size defaultScreenSize;

  setUp(() {
    bloc = MockLoginBloc();
    defaultScreenSize = const Size(1080, 1920);
  });

  group('LoginScreen', () {
    testWidgets(' > click on login button with empty email > show inline error Please enter your email', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(defaultScreenSize);
      final loginPageObject = LoginPageObject(tester: tester);
      when(() => bloc.state).thenReturn(LoginInitialized());

      await tester.pumpWidget(
        BlocProvider<LoginBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: LoginScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );

      //Act
      await loginPageObject.setEmail('');
      await loginPageObject.setPassword(r'Qwerty78$');
      await loginPageObject.tapLoginButton();

      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets(' >  click on login button with empty password > show inline error Please enter your password', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(const Size(740, 740));
      final loginPageObject = LoginPageObject(tester: tester);
      when(() => bloc.state).thenReturn(LoginInitialized());

      await tester.pumpWidget(
        BlocProvider<LoginBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: LoginScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );

      //Act
      await loginPageObject.setEmail('email@email.com');
      await loginPageObject.setPassword('');
      await loginPageObject.tapLoginButton();

      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Please enter your password'), findsOneWidget);
    });
  });
}
