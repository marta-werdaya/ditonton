import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });
  test('initial state should be empty', () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Error] when data is failed',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
