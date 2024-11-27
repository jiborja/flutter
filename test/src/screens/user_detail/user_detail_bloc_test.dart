import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/user_detail/bloc/user_detail_bloc.dart';

class MockUserDetailRepository extends Mock implements UserDetailRepository {}

void main() {
  late UserDetailBloc userDetailBloc;
  late UserDetail userDetail;
  late UserDetailRepository userDetailRepository;
  setUp(() {
    userDetail = UserDetail(age: 20);
    registerFallbackValue(userDetail);

    userDetailRepository = MockUserDetailRepository();
    userDetailBloc = UserDetailBloc(userDetailRepository: userDetailRepository);
  });

  group('UserDetailBloc', () {
    blocTest<UserDetailBloc, UserDetailState>(
      '> save age request > emit UserDetailSuccess state',
      //Arrange
      build: () => userDetailBloc,
      setUp: () {
        when(() => userDetailRepository.saveAge(any())).thenAnswer((_) async {});
      },
      //Act
      act: (bloc) => bloc.add(UserDetailSubmited(userDetail.age)),
      //Assert
      expect: () => <UserDetailState>[UserDetailInProccess(), UserDetailSuccess()],
    );

    blocTest<UserDetailBloc, UserDetailState>(
      '> save age request with negative number > emit UserDetailError',
      //Arrange
      build: () => userDetailBloc,
      setUp: () {
        when(() => userDetailRepository.saveAge(any())).thenAnswer((_) async {});
      },
      //Act
      act: (bloc) => bloc.add(const UserDetailSubmited(-10)),
      //Assert
      expect: () => [isA<UserDetailInProccess>(), isA<UserDetailError>()],
    );
  });
}
