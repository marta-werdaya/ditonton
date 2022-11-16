import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/poster_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('watchlist test', () {
    testWidgets('Add first movie into the watchlist', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Home Page
      expect(find.text('Now Playing'), findsOneWidget);
      final Finder poster = find.byType(PosterList<Movie>);
      await tester.tap(poster.at(0));
      await tester.pumpAndSettle();
      // Add to watchlist
      final Finder watchlistButton = find.byType(ElevatedButton);
      await tester.tap(watchlistButton);
      await tester.pumpAndSettle();
      // Back to Home
      final Finder backBtn = find.byIcon(Icons.arrow_back);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();
      // Open Drawer
      final Finder menu = find.byType(IconButton).first;
      await tester.tap(menu);
      await tester.pumpAndSettle();
      // Choose Watchlist
      final Finder watchlist = find.text('Watchlist');
      await tester.tap(watchlist);
      await tester.pumpAndSettle();
      // expect there is one item
      expect(find.text('List Masih Kosong'), findsNothing);
      await tester.pumpAndSettle();
    });
  });
}
