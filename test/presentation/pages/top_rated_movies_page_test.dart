import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class TopRatedMovieStateFake extends Fake implements TopRatedMovieState {}

class TopRatedMovieEventFake extends Fake implements TopRatedMovieEvent {}

void main() {
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMovieStateFake());
    registerFallbackValue(TopRatedMovieEventFake());
  });

  setUp(() {
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>.value(
      value: mockTopRatedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMovieBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoaded(testMovieList)));
    when(() => mockTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieLoaded(testMovieList));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movies).thenReturn(<Movie>[]);
    when(() => mockTopRatedMovieBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoaded(testMovieList)));
    when(() => mockTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieLoaded(testMovieList));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.Error);
    // when(mockNotifier.message).thenReturn('Error message');
    when(() => mockTopRatedMovieBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieError('error')));
    when(() => mockTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieError('error'));
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
