import 'package:flutter/material.dart';
import 'package:kid_good_good/kid/history/history.dart';
import 'package:test/test.dart';


void main() {
  group('Testing App Providers', () {
    var history = History();

    test('Check Missing Dates are found', () {

      // Should be 27 days missing since Feburary has 28 days
      final missingDays = history.findMissingDays([
        PointHistory(points: 12, dateTime: DateTime(2017, DateTime.february)),
        PointHistory(points: 12, dateTime: DateTime(2017, DateTime.march)),
      ], DateTime(2017, DateTime.march));

      expect(missingDays.where((element) => element is MissingPointHistory).length, 27);
      debugPrint("${missingDays.firstWhere((element) => element is MissingPointHistory)}");
    });
  });

}
