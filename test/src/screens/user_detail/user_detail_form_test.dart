import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:presentation/screens/user_detail/user_detail_screen.dart';

import 'page_object/user_detail_page_object.dart';

class MockUserDetailBloc extends MockBloc<UserDetailEvent, UserDetailState> implements UserDetailBloc {}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  late UserDetailBloc bloc;
  late Size defaultScreenSize;

  setUp(() async {
    bloc = MockUserDetailBloc();
    defaultScreenSize = const Size(1080, 1920);
  });
  group('UserDetailScreen', () {
    testWidgets(' > save age with empty textfield data > show Error Please enter your age', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(defaultScreenSize);
      final userDetailFormPageObject = UserDetailPageObject(tester: tester);

      when(() => bloc.state).thenReturn(UserDetailStarted());

      await tester.pumpWidget(
        BlocProvider<UserDetailBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: UserDetailScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );
      //Act
      await userDetailFormPageObject.setAge('');
      await userDetailFormPageObject.tapSaveButton();

      await tester.pumpAndSettle();
      //Assert
      expect(find.text('Please enter your age'), findsOneWidget);
    });

    testWidgets(' > save age with not number textfield data > show Error Please enter a valid number', (WidgetTester tester) async {
      //Arrange
      await binding.setSurfaceSize(const Size(740, 740));
      final userDetailFormPageObject = UserDetailPageObject(tester: tester);

      when(() => bloc.state).thenReturn(UserDetailStarted());

      await tester.pumpWidget(
        BlocProvider<UserDetailBloc>(
          create: (context) => bloc,
          child: const MaterialApp(
            title: 'test',
            home: Scaffold(
              body: UserDetailScreen(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [Locale('en')],
          ),
        ),
      );
      //Act
      await userDetailFormPageObject.setAge('characters');
      await userDetailFormPageObject.tapSaveButton();

      await tester.pumpAndSettle();
      //Assert
      expect(find.text('Please enter a valid number'), findsOneWidget);
    });
  });
}
