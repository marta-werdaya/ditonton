import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, RemoveWatchlist, SaveWatchlist])
void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });
  test('initial state should be empty', () {
    expect(movieWatchlistBloc.state, MovieWatchlistInitial());
  });
  final id = 1;
  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetWatchListStatus.execute(id)).thenAnswer((_) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchListStatus(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistLoaded(status: true, message: 'Remove From Watchlist')
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(id));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Loaded] when remove succesfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('success'));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchList(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistLoaded(status: false, message: 'success')
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Loaded] when remove failed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchList(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [MovieWatchlistLoading(), MovieWatchlistError('failed')],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Loaded] when save succesfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('success'));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSaveWatchList(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistLoaded(status: true, message: 'success')
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );
  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Loaded] when save failed',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSaveWatchList(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [MovieWatchlistLoading(), MovieWatchlistError('failed')],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );
}
