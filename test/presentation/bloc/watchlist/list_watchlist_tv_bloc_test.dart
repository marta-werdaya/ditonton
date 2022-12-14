import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist/list_watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'list_watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTvs;
  late ListWatchlistTvBloc listWatchlistTvBloc;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTv();
    listWatchlistTvBloc = ListWatchlistTvBloc(mockGetWatchlistTvs);
  });

  test('initial state should be empty', () {
    expect(listWatchlistTvBloc.state, TvEmpty());
  });

  blocTest<ListWatchlistTvBloc, ListWatchlistTvState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return listWatchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvLoading(),
      TvLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
  blocTest<ListWatchlistTvBloc, ListWatchlistTvState>(
    'Should emit [Loading, Empty] when data is gotten succesfully but there is no data',
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer((_) async => Right([]));
      return listWatchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvLoading(),
      TvEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
  blocTest<ListWatchlistTvBloc, ListWatchlistTvState>(
    'Should emit [Error] when data is failed',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return listWatchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvLoading(),
      TvError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
