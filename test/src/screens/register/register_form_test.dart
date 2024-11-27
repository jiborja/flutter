import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/register/bloc/register_bloc.dart';
import 'package:presentation/screens/register/register_screen.dart';

import 'page_object/register_page_object.dart';

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState> implements RegisterBloc {}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  late RegisterBloc bloc;
  late Size defaultScreenSize;

  setUp(() {
    bloc = MockRegisterBloc();
    defaultScreenSize = const Size(1080, 1920);
  });

  group('RegisterScreen', () {
    testWidgets(' > click on signup button with empty username > show inline error Please enter some text', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(defaultScreenSize);
      final registerPageObject = RegisterPageObject(tester: tester);
      when(() => bloc.state).thenReturn(RegisterStarted());

      await tester.pumpWidget(
        BlocProvider<RegisterBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: RegisterScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );
      //Act
      await registerPageObject.setUsername('');
      await registerPageObject.setEmail('email@email.com');
      await registerPageObject.setPassword(r'Qwerty78$');
      await registerPageObject.tapSaveButton();

      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Please enter some text'), findsOneWidget);
    });

    testWidgets(' > click on signup button with empty email > show inline error Please enter some text', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(const Size(740, 740));
      final registerPageObject = RegisterPageObject(tester: tester);
      when(() => bloc.state).thenReturn(RegisterStarted());

      await tester.pumpWidget(
        BlocProvider<RegisterBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: RegisterScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );
      //Act
      await registerPageObject.setUsername('username');
      await registerPageObject.setEmail('');
      await registerPageObject.setPassword(r'Qwerty78$');
      await registerPageObject.tapSaveButton();

      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Please enter some text'), findsOneWidget);
    });

    testWidgets(' > click on signup button  with empty password > show inline error Please enter some text', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(const Size(740, 740));
      final registerPageObject = RegisterPageObject(tester: tester);
      when(() => bloc.state).thenReturn(RegisterStarted());

      await tester.pumpWidget(
        BlocProvider<RegisterBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: RegisterScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );
      //Act
      await registerPageObject.setUsername('username');
      await registerPageObject.setEmail('email@email.com');
      await registerPageObject.setPassword('');
      await registerPageObject.tapSaveButton();

      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Please enter some text'), findsOneWidget);
    });
  });
}
