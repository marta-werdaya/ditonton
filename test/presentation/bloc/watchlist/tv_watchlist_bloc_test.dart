import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watch_list_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watch_list_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatusTv, RemoveWatchlistTv, SaveWatchlistTv])
void main() {
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late TvWatchlistBloc tvWatchlistBloc;

  setUp(() {
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(
      getWatchListStatusTv: mockGetWatchListStatusTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
      saveWatchlistTv: mockSaveWatchlistTv,
    );
  });
  test('initial state should be empty', () {
    expect(tvWatchlistBloc.state, TvWatchlistInitial());
  });
  final id = 1;
  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetWatchListStatusTv.execute(id)).thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchListStatusTv(id)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistLoaded(status: true, message: 'Remove From Watchlist')
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatusTv.execute(id));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, Loaded] when remove succesfully',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('success'));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistLoaded(status: false, message: 'success')
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );
  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, Loaded] when remove failed',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [TvWatchlistLoading(), TvWatchlistError('failed')],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    },
  );
  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, Loaded] when save succesfully',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('success'));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSaveWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistLoaded(status: true, message: 'success')
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );
  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, Loaded] when save failed',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSaveWatchListTv(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [TvWatchlistLoading(), TvWatchlistError('failed')],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
  );
}
