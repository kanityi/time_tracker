import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/app/models/job.dart';

void main() {
  group('fromMap method', () {
    test('null data', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });

    test('job with all properties', () {
      final job = Job.fromMap({'name': 'Teacher', 'ratePerHour': 10}, 'abc');
      expect(job, Job(name: 'Teacher', ratePerHour: 10, id: 'abc'));
    });
    test('missing name property', () {
      final job = Job.fromMap({'ratePerHour': 10}, 'abc');
      expect(job, null);
    });
  });

  group('toMap method', () {
    test('valid name, ratePerHour', () {
      final job = Job(name: 'Teacher', ratePerHour: 10, id: 'abc');
      expect(job.toMap(), {
        'name': 'Teacher',
        'ratePerHour': 10,
      });
    });
  });
}
