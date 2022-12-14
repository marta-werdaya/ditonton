import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist/list_watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'list_watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late ListWatchlistMovieBloc listWatchlistMovieBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    listWatchlistMovieBloc = ListWatchlistMovieBloc(mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(listWatchlistMovieBloc.state, Empty());
  });

  blocTest<ListWatchlistMovieBloc, ListWatchlistMovieState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return listWatchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      Loaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
  blocTest<ListWatchlistMovieBloc, ListWatchlistMovieState>(
    'Should emit [Loading, Empty] when data is gotten succesfully but there is no data',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right([]));
      return listWatchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      Empty(),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
  blocTest<ListWatchlistMovieBloc, ListWatchlistMovieState>(
    'Should emit [Error] when data is failed',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return listWatchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      Error('failed'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
