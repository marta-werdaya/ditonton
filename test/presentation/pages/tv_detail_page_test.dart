import 'package:ditonton/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class MockTvWatchlistBloc extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}

class TvWatchlistStateFake extends Fake implements TvWatchlistState {}

class TvWatchlistEventFake extends Fake implements TvWatchlistEvent {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvWatchlistStateFake());
    registerFallbackValue(TvWatchlistEventFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: BlocProvider<TvWatchlistBloc>.value(
        value: mockTvWatchlistBloc,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList)));
    when(() => mockTvDetailBloc.state).thenReturn(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList));
    when(() => mockTvWatchlistBloc.stream).thenAnswer((_) =>
        Stream.value(TvWatchlistLoaded(status: false, message: 'message')));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(TvWatchlistLoaded(status: false, message: 'message'));

    final widget = TvDetailPage(id: 1);
    await tester.pumpWidget(_makeTestableWidget(widget));
    await tester.pump(Duration(seconds: 5));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList)));
    when(() => mockTvDetailBloc.state).thenReturn(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList));
    when(() => mockTvWatchlistBloc.stream).thenAnswer((_) =>
        Stream.value(TvWatchlistLoaded(status: true, message: 'message')));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(TvWatchlistLoaded(status: true, message: 'message'));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList)));
    when(() => mockTvDetailBloc.state).thenReturn(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList));
    when(() => mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockTvWatchlistBloc.state).thenReturn(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist'));

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);
    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added To Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList)));
    when(() => mockTvDetailBloc.state).thenReturn(
        TvDetailLoaded(tv: testTvDetail, tvRecomendation: testTvList));
    when(() => mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockTvWatchlistBloc.state).thenReturn(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist'));
    when(() => mockTvWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(TvWatchlistError('Failed')));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(TvWatchlistError('Failed'));
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Should Display Cicular progress Indicator when Requesstate loading.',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.stream)
        .thenAnswer((_) => Stream.value(TvDetailLoading()));
    when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoading());
    when(() => mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockTvWatchlistBloc.state).thenReturn(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist'));
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should Display Text With Error message.',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.stream)
        .thenAnswer((_) => Stream.value(TvDetailError('failed')));
    when(() => mockTvDetailBloc.state).thenReturn(TvDetailError('failed'));
    when(() => mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockTvWatchlistBloc.state).thenReturn(
        TvWatchlistLoaded(status: false, message: 'Added To Watchlist'));
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
    await tester.pump(Duration(seconds: 2));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });
}
