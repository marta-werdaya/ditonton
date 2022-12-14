import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTvs;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTvs);
  });
  test('initial state should be empty', () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Error] when data is failed',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}
