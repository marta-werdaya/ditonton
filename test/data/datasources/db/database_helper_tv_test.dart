import 'package:ditonton/data/datasources/db/database_helper_tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DatabaseHelperTv databaseHelper;

  setUp(() async {
    databaseHelper = DatabaseHelperTv();
  });

  test('Should Use singleton pattern', () {
    final testIntit = DatabaseHelperTv();
    final result = DatabaseHelperTv();

    expect(result, equals(testIntit));
  });
}
