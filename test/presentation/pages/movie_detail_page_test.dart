import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([MovieDetailBloc])
class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

void main() {
  setUp(() {
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());
  });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<MovieDetailNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>(
      create: (context) => MockMovieDetailBloc(),
      child: MaterialApp(
        title: '',
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    final widget = MovieDetailPage(id: 1);
    final mockDetailMovieWidget = MockMovieDetailBloc();
    when(() => mockDetailMovieWidget.state).thenReturn(MovieDetailLoaded(
        movie: testMovieDetail, movieRecomendation: testMovieList));

    // when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    // when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(widget));
    // await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    // when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    // when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    // when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    // when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    // when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

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
    // when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    // when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    // when(mockNotifier.watchlistMessage).thenReturn('Failed');

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
    // when(mockNotifier.movieState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should Display Text With Error message.',
      (WidgetTester tester) async {
    // when(mockNotifier.movieState).thenReturn(RequestState.Error);
    // when(mockNotifier.message).thenReturn('failed');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump(Duration(seconds: 2));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });
}
