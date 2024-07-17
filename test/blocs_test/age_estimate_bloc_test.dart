import 'package:age_estimater/data/model/age_model.dart';
import 'package:age_estimater/domain/repository/age_estimate_repository/age_estimate_repository.dart';
import 'package:age_estimater/presentation/screens/age_estimate/bloc/age_estimate_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAgeEstimateRepository extends Mock implements AgeEstimateRepository {}

class FakeGetAgeEvent extends Fake implements GetAgeEvent {}

class FakeResetEvent extends Fake implements ResetEvent {}

void main() {
  late AgeEstimateBloc ageEstimateBloc;
  late MockAgeEstimateRepository mockAgeEstimateRepository;

  setUp(() {
    registerFallbackValue(FakeGetAgeEvent());
    registerFallbackValue(FakeResetEvent());
    mockAgeEstimateRepository = MockAgeEstimateRepository();
    ageEstimateBloc = AgeEstimateBloc(ageRepository: mockAgeEstimateRepository);
  });

  tearDown(() {
    ageEstimateBloc.close();
  });

  group('AgeEstimateBloc Tests', () {
    test('emit AgeInitial', () {
      expect(ageEstimateBloc.state, AgeInitial());
    });

    blocTest<AgeEstimateBloc, AgeEstimateState>(
      'emits [AgeLoading, AgeLoaded] when GetAgeEvent is called',
      build: () {
        when(() => mockAgeEstimateRepository.getAgeEstimate(any())).thenAnswer(
              (_) async => AgeEstimateModel(count: 3122, name: "saud", age: 53),
        );
        return ageEstimateBloc;
      },
      act: (bloc) => bloc.add(const GetAgeEvent('saud')),
      expect: () => [AgeLoading(), const AgeLoaded(53, 'saud')],
    );

    blocTest<AgeEstimateBloc, AgeEstimateState>(
      'emits [AgeLoading, AgeError] when GetAgeEvent is called and repository throws an error',
      build: () {
        when(() => mockAgeEstimateRepository.getAgeEstimate(any())).thenThrow(
          Exception('Failed to load age estimate'),
        );
        return ageEstimateBloc;
      },
      act: (bloc) => bloc.add(const GetAgeEvent('saud')),
      expect: () => [
        AgeLoading(),
        const AgeError('Exception: Failed to load age estimate')
      ],
    );

    blocTest<AgeEstimateBloc, AgeEstimateState>(
      'emits [AgeInitial] when ResetEvent is called',
      build: () => ageEstimateBloc,
      act: (bloc) => bloc.add(ResetEvent()),
      expect: () => [AgeInitial()],
    );
  });
}
