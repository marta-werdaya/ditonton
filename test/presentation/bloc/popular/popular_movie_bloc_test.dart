import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie_list_notifier_test.mocks.dart';

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc popularMovieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });
  test('initial state should be empty', () {
    expect(popularMovieBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
