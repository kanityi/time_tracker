import 'package:equatable/equatable.dart';

abstract class YouAwesomeState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  YouAwesomeState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  YouAwesomeState getStateCopy();

  YouAwesomeState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnYouAwesomeState extends YouAwesomeState {

  UnYouAwesomeState(int version) : super(version);

  @override
  String toString() => 'UnYouAwesomeState';

  @override
  UnYouAwesomeState getStateCopy() {
    return UnYouAwesomeState(0);
  }

  @override
  UnYouAwesomeState getNewVersion() {
    return UnYouAwesomeState(version+1);
  }
}

/// Initialized
class InYouAwesomeState extends YouAwesomeState {
  final String hello;

  InYouAwesomeState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InYouAwesomeState $hello';

  @override
  InYouAwesomeState getStateCopy() {
    return InYouAwesomeState(this.version, this.hello);
  }

  @override
  InYouAwesomeState getNewVersion() {
    return InYouAwesomeState(version+1, this.hello);
  }
}

class ErrorYouAwesomeState extends YouAwesomeState {
  final String errorMessage;

  ErrorYouAwesomeState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorYouAwesomeState';

  @override
  ErrorYouAwesomeState getStateCopy() {
    return ErrorYouAwesomeState(this.version, this.errorMessage);
  }

  @override
  ErrorYouAwesomeState getNewVersion() {
    return ErrorYouAwesomeState(version+1, this.errorMessage);
  }
}
