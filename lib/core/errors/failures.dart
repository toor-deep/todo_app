import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final String? type;

  const Failure({this.message, this.type});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.type});

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return super.message ?? "";
  }
}

class GenericFailure extends Failure {
  const GenericFailure({super.message, super.type});

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return super.message ?? "";
  }
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return super.message ?? "";
  }
}

class UserNotFound extends CacheFailure {
  @override
  String toString() {
    return super.message ?? "";
  }
}

class InternetFailure extends Failure {
  InternetFailure({super.message}) {
  }

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return super.message ?? "";
  }
}
