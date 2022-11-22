import 'package:ditonton/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: 'airdate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );
  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tSeasonModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": 'airdate',
        "episode_count": 1,
        "id": 1,
        "name": 'name',
        'overview': 'overview',
        'poster_path': 'posterPath',
        'season_number': 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
