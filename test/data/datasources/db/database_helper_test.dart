import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUp(() async {
    databaseHelper = DatabaseHelper();
  });

  test('Should Use singleton pattern', () {
    final testIntit = DatabaseHelper();
    final result = DatabaseHelper();

    expect(result, equals(testIntit));
  });
}
