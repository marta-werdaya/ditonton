import 'package:ditonton/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, MovieWatchlistBloc])
class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

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
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    final widget = MovieDetailPage(id: 1);
    when(() => mockMovieDetailBloc.add(OnGetMovieDetail(1)))
        .thenReturn(MovieDetailLoading());
    when(() => mockMovieWatchlistBloc.add(OnGetWatchListStatus(1)))
        .thenReturn(MovieWatchlistLoading());

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(widget));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Should Display Cicular progress Indicator when Requesstate loading.',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should Display Text With Error message.',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump(Duration(seconds: 2));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });
}
