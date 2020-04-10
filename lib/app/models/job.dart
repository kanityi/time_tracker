import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Job with EquatableMixin {
  Job({@required this.name, @required this.ratePerHour, @required this.id});
  final String id;
  final String name;
  final int ratePerHour;

  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    final int ratePerHour = data['ratePerHour'];
    if (ratePerHour == null) {
      return null;
    }
    return Job(name: name, ratePerHour: ratePerHour, id: documentId);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }

  @override
  List get props {
    return [id, name, ratePerHour];
  }

  @override
  bool get stringify => true;
}
