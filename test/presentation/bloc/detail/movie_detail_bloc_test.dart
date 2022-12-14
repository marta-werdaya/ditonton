import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });
  test('initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });
  final id = 1;
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetMovieDetail.execute(id))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Right(testMovieList));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetMovieDetail(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(
          movie: testMovieDetail, movieRecomendation: testMovieList)
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
      verify(mockGetMovieRecommendations.execute(id));
    },
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetMovieDetail.execute(id))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetMovieDetail(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
      verify(mockGetMovieRecommendations.execute(id));
    },
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetMovieDetail.execute(id))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetMovieDetail(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
      verify(mockGetMovieRecommendations.execute(id));
    },
  );
}
