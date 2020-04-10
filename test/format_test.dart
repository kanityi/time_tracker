import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('given positive number of hours', () {
      expect(Format.hours(10), '10h');
    });
    test('given 0 as hours', () {
      expect(Format.hours(0), '0h');
    });
    test('given negative number as hours', () {
      expect(Format.hours(-1), '0h');
    });
    test('given decimal value number as hours', () {
      expect(Format.hours(4.5), '4.5h');
    });
  });
  group('date - GB locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2019-08-12', () {
      expect(Format.date(DateTime(2019, 08, 12)), '12 Aug 2019');
    });
  });

  group('dayOfWeek - GB locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Monday', () {
      expect(Format.dayOfWeek(DateTime(2019, 08, 12)), 'Mon');
    });
  });

  group('dayOfWeek - IT locale', () {
    setUp(() async {
      Intl.defaultLocale = 'it_IT';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Lunedi', () {
      expect(Format.dayOfWeek(DateTime(2019, 08, 12)), 'lun');
    });
  });

  group('currency - ZA locale', () {
    setUp(() {
      Intl.defaultLocale = 'en_ZA';
    });
    test('given positive number of rand', () {
      expect(Format.currency(10), 'R10');
    });
    test('given 0 as rand', () {
      expect(Format.currency(0), '');
    });
    test('given negative number as rand', () {
      expect(Format.currency(-1), '-R1');
    });
  });

  group('currency - US locale', () {
    setUp(() {
      Intl.defaultLocale = 'en_US';
    });
    test('given positive number of rand', () {
      expect(Format.currency(10), '\$10');
    });
    test('given 0 as rand', () {
      expect(Format.currency(0), '');
    });
    test('given negative number as rand', () {
      expect(Format.currency(-1), '-\$1');
    });
  });
}
