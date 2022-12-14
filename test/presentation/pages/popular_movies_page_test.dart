import 'package:ditonton/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class PopularMovieStateFake extends Fake implements PopularMovieState {}

class PopularMovieEventFake extends Fake implements PopularMovieEvent {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUpAll(() {
    registerFallbackValue(PopularMovieStateFake());
    registerFallbackValue(PopularMovieEventFake());
  });

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoaded(testMovieList)));
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMovieLoaded(testMovieList));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movies).thenReturn(<Movie>[]);
    when(() => mockPopularMovieBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoaded(testMovieList)));
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMovieLoaded(testMovieList));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.Error);
    // when(mockNotifier.message).thenReturn('Error message');
    when(() => mockPopularMovieBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieError('error')));
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMovieError('error'));
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
