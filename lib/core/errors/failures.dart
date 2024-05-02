import 'package:equatable/equatable.dart';

/// Abstract class representing failures.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure representing errors related to network connectivity.
class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);
}

/// Failure representing errors related to server communication.
class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message);
}

/// Failure representing errors related to caching data.
class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message);
}
