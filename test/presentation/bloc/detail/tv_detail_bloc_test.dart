import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetTvRecommendations])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late TvDetailBloc tvDetailBloc;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
    );
  });
  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });
  final id = 1;
  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Right(testTvList));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetTvDetail(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList)
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
      verify(mockGetTvRecommendations.execute(id));
    },
  );
  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetTvDetail(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
      verify(mockGetTvRecommendations.execute(id));
    },
  );
  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetTvDetail(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
      verify(mockGetTvRecommendations.execute(id));
    },
  );
}
