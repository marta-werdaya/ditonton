import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = testTvTable.toJson();
      // assert
      expect(result, testTvMap);
    });
  });
}
