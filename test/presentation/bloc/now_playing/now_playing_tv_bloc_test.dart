import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTvs;
  late NowPlayingTvBloc nowPlayingTvBloc;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTvs);
  });
  test('initial state should be empty', () {
    expect(nowPlayingTvBloc.state, NowPlayingTvEmpty());
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Loading, Loaded] when data is gotten succesfully',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
    },
  );
  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [Error] when data is failed',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Left(ConnectionFailure('failed')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvs()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvError('failed'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
    },
  );
}
