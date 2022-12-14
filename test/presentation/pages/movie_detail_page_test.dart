import 'package:ditonton/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MovieWatchlistStateFake extends Fake implements MovieWatchlistState {}

class MovieWatchlistEventFake extends Fake implements MovieWatchlistEvent {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
    registerFallbackValue(MovieWatchlistEventFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: BlocProvider<MovieWatchlistBloc>.value(
        value: mockMovieWatchlistBloc,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
        MovieDetailLoaded(
            movie: testMovieDetail, movieRecomendation: testMovieList)));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(
        movie: testMovieDetail, movieRecomendation: testMovieList));
    when(() => mockMovieWatchlistBloc.stream).thenAnswer((_) =>
        Stream.value(MovieWatchlistLoaded(status: false, message: 'message')));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistLoaded(status: false, message: 'message'));

    final widget = MovieDetailPage(id: 1);
    await tester.pumpWidget(_makeTestableWidget(widget));
    await tester.pump(Duration(seconds: 5));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    final findText = find.text('Watchlist');

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
        MovieDetailLoaded(
            movie: testMovieDetail, movieRecomendation: testMovieList)));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(
        movie: testMovieDetail, movieRecomendation: testMovieList));
    when(() => mockMovieWatchlistBloc.stream).thenAnswer((_) =>
        Stream.value(MovieWatchlistLoaded(status: true, message: 'message')));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistLoaded(status: true, message: 'message'));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
        MovieDetailLoaded(
            movie: testMovieDetail, movieRecomendation: testMovieList)));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(
        movie: testMovieDetail, movieRecomendation: testMovieList));
    when(() => mockMovieWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist'));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

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
    when(() => mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
        MovieDetailLoaded(
            movie: testMovieDetail, movieRecomendation: testMovieList)));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(
        movie: testMovieDetail, movieRecomendation: testMovieList));
    when(() => mockMovieWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist'));
    when(() => mockMovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchlistError('Failed')));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistError('Failed'));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Should Display Cicular progress Indicator when Requesstate loading.',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailLoading()));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => mockMovieWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist'));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should Display Text With Error message.',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailError('failed')));
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailError('failed'));
    when(() => mockMovieWatchlistBloc.stream).thenAnswer((_) => Stream.value(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist')));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        MovieWatchlistLoaded(status: false, message: 'Added To Watchlist'));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump(Duration(seconds: 2));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });
}
