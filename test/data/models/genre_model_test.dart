import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');
  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "name",
      };
      expect(result, expectedJsonMap);
    });
  });
}
