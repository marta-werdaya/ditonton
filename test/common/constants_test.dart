import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should Return TextStyle when kSubtitle Called', () async {
    final res = kSubtitle;

    expect(res, isA<TextStyle>());
  });
  test('Should Return TextStyle when kBodyText Called', () async {
    final res = kBodyText;

    expect(res, isA<TextStyle>());
  });

  test('Should Return TextTheme when kTextTheme Called', () async {
    final res = kTextTheme;
    expect(res, isA<TextTheme>());
  });
}
